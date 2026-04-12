import os
import json
import logging
import requests
from datetime import datetime
from typing import Literal, List, Optional, Tuple

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from notion_client import Client

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="Qubrix Backend", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

NOTION_API_KEY = os.getenv("NOTION_API_KEY", "")
NOTION_DATABASE_ID = os.getenv("NOTION_DATABASE_ID", "").replace("-", "")
XAI_API_KEY = os.getenv("XAI_API_KEY", "")
XAI_MODEL = os.getenv("XAI_MODEL", "grok-beta") 
XAI_BASE_URL = "https://api.x.ai/v1"

notion = Client(auth=NOTION_API_KEY) if NOTION_API_KEY else None

class AnalyzeRequest(BaseModel):
    images_count: int = Field(0, ge=0, le=500)
    voice_seconds: int = Field(0, ge=0, le=3600)
    social_presence: Literal["low", "medium", "high"]

class AnalyzeResponse(BaseModel):
    risk_score: int
    risk_level: Literal["Low", "Medium", "High"]
    analysis: str
    impersonation_message: str
    recommendations: List[str]
    user_warning: str

class SaveRequest(BaseModel):
    risk_score: int
    risk_level: str
    analysis: str
    timestamp: Optional[str] = None

def grok_generate(payload: AnalyzeRequest, risk_level: str) -> Tuple[str, List[str]]:
    if not XAI_API_KEY:
        raise ValueError("XAI_API_KEY not set")

    prompt = (
        f"Context: User has {payload.images_count} public images, {payload.voice_seconds}s of audio, "
        f"and {payload.social_presence} social presence. Risk Level: {risk_level}.\n"
        "1. Write one realistic 2-sentence scam message a hacker would send using this data.\n"
        "2. Provide 5 advanced, non-generic security tips.\n"
        "Format as JSON: {\"message\": \"...\", \"tips\": [\"...\", \"...\"]}"
    )

    try:
        response = requests.post(
            f"{XAI_BASE_URL}/chat/completions",
            headers={"Authorization": f"Bearer {XAI_API_KEY}"},
            json={
                "model": XAI_MODEL,
                "messages": [
                    {"role": "system", "content": "You are a cybersecurity expert. Output valid JSON only."},
                    {"role": "user", "content": prompt}
                ],
                "temperature": 0.6
            },
            timeout=10
        )
        response.raise_for_status()
        data = response.json()
        content = data["choices"][0]["message"]["content"].replace("```json", "").replace("```", "").strip()
        parsed = json.loads(content)
        return parsed["message"], parsed["tips"]
    except Exception as e:
        logger.error(f"Grok Error: {e}")
        raise e

@app.post("/analyze", response_model=AnalyzeResponse)
async def analyze(payload: AnalyzeRequest):
    score = min((payload.images_count * 2) + (payload.voice_seconds // 3), 80)
    presence_map = {"low": 5, "medium": 12, "high": 20}
    score += presence_map.get(payload.social_presence, 0)
    score = min(100, score)

    level = "Low" if score < 35 else "Medium" if score < 70 else "High"
    
    im_msg = "Hey, it's me. I'm using a temporary number. Can you verify a code for me?"
    recs = ["Enable 2FA", "Limit public social media exposure", "Use a vault for sensitive ID docs"]

    try:
        im_msg, recs = grok_generate(payload, level)
    except:
        logger.warning("Using fallback content due to Grok failure.")

    return {
        "risk_score": score,
        "risk_level": level,
        "analysis": f"Based on {payload.images_count} images and {payload.voice_seconds}s of voice data, your identity footprint is significant.",
        "impersonation_message": im_msg,
        "recommendations": recs,
        "user_warning": "Qubrix never asks for your credentials via text."
    }

@app.post("/save")
async def save(payload: SaveRequest):
    if not notion:
        return {"success": False, "message": "Notion not configured"}
    
    try:
        notion.pages.create(
            parent={"database_id": NOTION_DATABASE_ID},
            properties={
                "Name": {"title": [{"text": {"content": f"Scan {datetime.now().strftime('%Y-%m-%d %H:%M')}"}}]},
                "Risk Score": {"number": payload.risk_score},
                "Risk Level": {"select": {"name": payload.risk_level}},
                "Analysis": {"rich_text": [{"text": {"content": payload.analysis[:2000]}}]}
            }
        )
        return {"success": True, "message": "Logged to Notion"}
    except Exception as e:
        logger.error(f"Notion Save Error: {e}")
        return {"success": False, "message": str(e)}