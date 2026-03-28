from fastapi import FastAPI

app = FastAPI(title="Qubrix Backend", version="0.1.0")

@app.get("/health")
def health():
    return {"status": "ok", "message": "Qubrix backend is running"}