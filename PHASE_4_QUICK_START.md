# Phase 4 Quick Start Checklist

**Status**: Backend ✅ READY | Flutter 🚀 NEXT

---

## Backend Done ✅

- ✅ Updated `main.py` with `/save` endpoint
- ✅ Updated `requirements.txt` with `notion-client` + `python-dotenv`

**Files Changed:**
- [Qubrix_Python/main.py](Qubrix_Python/main.py) - Added SaveRequest, SaveResponse, /save endpoint
- [Qubrix_Python/requirements.txt](Qubrix_Python/requirements.txt) - Added notion-client==0.22.0

---

## Next: Flutter Implementation 🚀

### Step 1: Create BLoC Files (4 files)

Copy-paste code from [PHASE_4_NOTION_INTEGRATION.md](PHASE_4_NOTION_INTEGRATION.md#51-create-savebloc):

1. **`lib/BLoC/Save/save_bloc.dart`**
2. **`lib/BLoC/Save/save_event.dart`**
3. **`lib/BLoC/Save/save_state.dart`**

### Step 2: Create Model Files (2 files)

Copy-paste from [PHASE_4_NOTION_INTEGRATION.md](PHASE_4_NOTION_INTEGRATION.md#54-create-models):

1. **`lib/Models/save_request.dart`**
2. **`lib/Models/save_response.dart`**

### Step 3: Update API Service

Add `saveToNotion()` method to `lib/Services/api_service.dart` (see section 5.5 in guide)

### Step 4: Update UploadScreen

Update navigation in `lib/Screens/UploadScreen/upload_screen.dart` to pass data to ResultScreen

### Step 5: Update ResultScreen

Replace content of `lib/Screens/ResultScreen/result_screen.dart` with code from section 5.6 in guide

---

## Before Deploying to Render

1. **Setup Notion Database** (see [PHASE_4_NOTION_INTEGRATION.md](PHASE_4_NOTION_INTEGRATION.md#️-step-1-create-notion-database))
   - [ ] Create database in Notion
   - [ ] Add all properties (timestamp, risk_score, risk_level, etc.)
   - [ ] Get Database ID

2. **Create API Credentials** (see section 2)
   - [ ] Generate Notion API Key
   - [ ] Share database with integration
   - [ ] Copy both credentials

3. **Local Test** (before Render)
   ```bash
   cd d:\Projects\Qubrix\Qubrix_Python
   pip install -r requirements.txt
   set NOTION_API_KEY=secret_xxxxx...
   set NOTION_DATABASE_ID=xxx...
   python -m uvicorn main:app --reload --port 8000
   ```

4. **Deploy to Render**
   - Add environment variables (see section 4.1)
   - Push code to git
   - Render auto-deploys

---

## Testing Flow

### Local (Before Render):
```
1. Start backend: uvicorn main:app --reload
2. Run Flutter: flutter run
3. Flow: Splash → Connectivity → Upload (fill form) → Analysis → ResultScreen
4. Click "Save to Notion" button
5. Check Notion database for new entry
```

### Production (After Render):
```
1. Deploy to Render (auto-redeploys on git push)
2. Update Flutter AppConfig.baseUrl to https://qubrix-q5ai.onrender.com
3. Run full test flow
4. Verify Notion entry appears
```

---

## Document References

**Full detailed guide**: [PHASE_4_NOTION_INTEGRATION.md](PHASE_4_NOTION_INTEGRATION.md)
- Notion database setup (Step 1)
- Notion credentials (Step 2)
- Flutter BLoC code (Step 5)
- Testing checklist

**Status**: Ready to execute Flutter implementation

**Est. Time**: 30 mins (BLoC files) + 10 mins (Notion setup) + 15 mins (testing)
