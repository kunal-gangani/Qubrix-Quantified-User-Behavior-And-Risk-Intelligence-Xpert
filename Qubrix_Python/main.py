from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from typing import Literal, List, Optional
from datetime import datetime
import os
from notion_client import Client

app = FastAPI(title="Qubrix Backend", version="0.3.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

NOTION_API_KEY = os.getenv("NOTION_API_KEY", "")
NOTION_DATABASE_ID = os.getenv("NOTION_DATABASE_ID", "")
notion = Client(auth=NOTION_API_KEY) if NOTION_API_KEY else None

@app.get("/")
def root():
	return {"message": "Qubrix backend is running", "try": ["/health", "/docs"]}

@app.get("/health")
def health():
	return {"status": "ok", "message": "Qubrix backend is running"}

class AnalyzeRequest(BaseModel):
	images_count: int = Field(ge=0, le=500)
	voice_seconds: int = Field(ge=0, le=3600)
	social_presence: Literal["low", "medium", "high"]

class AnalyzeResponse(BaseModel):
	risk_score: int
	risk_level: Literal["Low", "Medium", "High"]
	analysis: str
	impersonation_message: str
	recommendations: List[str]
	user_warning: str

@app.post("/analyze", response_model=AnalyzeResponse)
def analyze(payload: AnalyzeRequest):
	score = 0
	score += min(payload.images_count * 2, 40)
	score += min(int(payload.voice_seconds / 3), 40)

	if payload.social_presence == "low":
		score += 5
	elif payload.social_presence == "medium":
		score += 12
	else:
		score += 20

	score = max(0, min(100, score))

	if score < 35:
		level: Literal["Low", "Medium", "High"] = "Low"
	elif score < 70:
		level = "Medium"
	else:
		level = "High"

	analysis = (
		f"We detected enough public material to attempt a convincing profile clone. "
		f"Images: {payload.images_count}, voice: {payload.voice_seconds}s, presence: {payload.social_presence}. "
		f"Overall risk is {level.lower()}."
	)

	impersonation_message = (
		"Hey, it’s me — I changed my number. Can you send the OTP you just received? Need to log in urgently."
		if level != "Low"
		else "Hi, quick check: is this still your number? I might have messaged the wrong contact."
	)

	recommendations = [
		"Enable 2-factor authentication on email and social accounts.",
		"Lock down social profiles and remove public phone/email if visible.",
		"Set a family/friends verification phrase for urgent requests.",
		"Be cautious with unknown calls requesting voice samples or OTPs.",
	]
	if level == "High":
		recommendations.insert(0, "Treat unexpected messages as potential impersonation until verified.")
	if level == "Low":
		recommendations.append("Keep monitoring new public posts and review privacy settings monthly.")

	user_warning = "Never share OTPs or password reset codes, even if the message looks real."

	return AnalyzeResponse(
		risk_score=score,
		risk_level=level,
		analysis=analysis,
		impersonation_message=impersonation_message,
		recommendations=recommendations,
		user_warning=user_warning,
	)

class SaveRequest(BaseModel):
	risk_score: int
	risk_level: Literal["Low", "Medium", "High"]
	analysis: str
	timestamp: Optional[str] = None  

class SaveResponse(BaseModel):
	success: bool
	message: str
	notion_page_id: Optional[str] = None

@app.post("/save", response_model=SaveResponse)
def save_to_notion(payload: SaveRequest):
	if not NOTION_API_KEY or not NOTION_DATABASE_ID or notion is None:
		return SaveResponse(success=False, message="Notion integration not configured on server")

	ts = payload.timestamp or datetime.now().isoformat()

	try:
		page = notion.pages.create(
			parent={"database_id": NOTION_DATABASE_ID},
			properties={
				"Name": {"title": [{"text": {"content": f"{payload.risk_level} Risk - {ts}"}}]},
				"Risk Score": {"number": payload.risk_score},
				"Risk Level": {"select": {"name": payload.risk_level}},
				"Timestamp": {"date": {"start": ts}},
				"Analysis": {"rich_text": [{"text": {"content": payload.analysis}}]},
			},
		)
		return SaveResponse(success=True, message="Saved to Notion", notion_page_id=page["id"])
	except Exception as e:
		return SaveResponse(success=False, message=f"Error saving to Notion: {str(e)}")