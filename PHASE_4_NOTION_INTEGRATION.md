# Phase 4: Notion Integration Setup Guide

**Date**: 2026-03-29  
**Objective**: Create Notion database + `/save` endpoint for persisting risk analysis

---

## 🗂️ Step 1: Create Notion Database

### 1.1 Go to Notion and Create New Database

1. Open https://notion.so
2. Login to your account
3. Create a new page (or use existing workspace)
4. Click "+ Add a database"
5. Select "Table" view
6. Name it: `Qubrix Analysis Results`

---

### 1.2 Set Up Database Properties

Your database should have these columns:

| Property | Type | Description |
|----------|------|-------------|
| `Title` | Title | Auto-generated (keep as-is) |
| `timestamp` | Date | When analysis was created |
| `risk_score` | Number | 0-100 risk score |
| `risk_level` | Select | Low / Medium / High |
| `analysis` | Rich Text | Analysis text |
| `impersonation_message` | Rich Text | Example impersonation message |
| `recommendations` | Rich Text | Numbered list of recommendations |
| `user_warning` | Rich Text | User warning message |
| `images_count` | Number | Number of images |
| `voice_seconds` | Number | Voice recording duration |
| `social_presence` | Select | low / medium / high |

### Step-by-Step Property Creation:

**Already exists:**
- `Title` (default)

**Add new properties in Notion UI:**

1. Click "+" next to last column
2. Add "timestamp" → Type: Date → Done
3. Add "risk_score" → Type: Number → Done
4. Add "risk_level" → Type: Select → Options: Low, Medium, High → Done
5. Add "analysis" → Type: Rich Text → Done
6. Add "impersonation_message" → Type: Rich Text → Done
7. Add "recommendations" → Type: Rich Text → Done
8. Add "user_warning" → Type: Rich Text → Done
9. Add "images_count" → Type: Number → Done
10. Add "voice_seconds" → Type: Number → Done
11. Add "social_presence" → Type: Select → Options: low, medium, high → Done

---

## 🔑 Step 2: Get Notion Credentials

### 2.1 Get Notion API Key

1. Go to https://www.notion.so/my-integrations
2. Click "Create new integration"
3. Name: `Qubrix Backend`
4. Choose workspace where your database lives
5. Click "Submit"
6. Copy the **Internal Integration Token** (looks like `secret_xxxxx...`)
7. **Save this** - you'll need it for environment variables

### 2.2 Get Database ID

1. Open your Notion database page in browser
2. Look at the URL:
   ```
   https://www.notion.so/workspace/[DATABASE_ID]?v=xxxxx
   ```
   or
   ```
   https://www.notion.so/[DATABASE_ID]?v=xxxxx
   ```
3. The part between `notion.so/` and `?` is your Database ID
4. Remove any hyphens to get: `databaseid` (32 characters)
5. **Save this** - you'll need it for environment variables

### 2.3 Share Database with Integration

1. In your Notion database, click "Share" (top right)
2. Click "Invite"
3. Search for "Qubrix Backend" (your integration)
4. Click to add it
5. Click "Invite"

**Done!** Now your integration can read/write to this database.

---

## 🔧 Step 3: Backend Implementation

### 3.1 Install Notion Python Client

Update your `requirements.txt`:

```txt
fastapi==0.115.0
uvicorn[standard]==0.30.6
python-dotenv==1.0.0
notion-client==0.22.0
```

Then install:
```bash
cd d:\Projects\Qubrix\Qubrix_Python
pip install -r requirements.txt
```

### 3.2 Update main.py with /save Endpoint

Add this code to your `main.py` (after the `/analyze` endpoint):

```python
import os
from notion_client import Client

# Initialize Notion client
notion_api_key = os.getenv("NOTION_API_KEY", "")
notion_database_id = os.getenv("NOTION_DATABASE_ID", "")
notion = Client(auth=notion_api_key) if notion_api_key else None

class SaveRequest(BaseModel):
    risk_score: int
    risk_level: Literal["Low", "Medium", "High"]
    analysis: str
    impersonation_message: str
    recommendations: List[str]
    user_warning: str
    images_count: int
    voice_seconds: int
    social_presence: Literal["low", "medium", "high"]

class SaveResponse(BaseModel):
    success: bool
    message: str
    notion_page_id: str | None = None

@app.post("/save", response_model=SaveResponse)
def save_to_notion(payload: SaveRequest):
    """Save analysis results to Notion database."""
    
    # Validate Notion configuration
    if not notion_api_key or not notion_database_id:
        return SaveResponse(
            success=False,
            message="Notion integration not configured on server",
            notion_page_id=None
        )
    
    try:
        # Format recommendations as numbered list
        recommendations_text = "\n".join(
            [f"{i+1}. {rec}" for i, rec in enumerate(payload.recommendations)]
        )
        
        # Create page in Notion database
        page = notion.pages.create(
            parent={"database_id": notion_database_id},
            properties={
                "Title": {
                    "title": [
                        {
                            "text": {
                                "content": f"{payload.risk_level} Risk - {datetime.now().strftime('%Y-%m-%d %H:%M')}"
                            }
                        }
                    ]
                },
                "timestamp": {
                    "date": {"start": datetime.now().isoformat()}
                },
                "risk_score": {
                    "number": payload.risk_score
                },
                "risk_level": {
                    "select": {"name": payload.risk_level}
                },
                "analysis": {
                    "rich_text": [
                        {"text": {"content": payload.analysis}}
                    ]
                },
                "impersonation_message": {
                    "rich_text": [
                        {"text": {"content": payload.impersonation_message}}
                    ]
                },
                "recommendations": {
                    "rich_text": [
                        {"text": {"content": recommendations_text}}
                    ]
                },
                "user_warning": {
                    "rich_text": [
                        {"text": {"content": payload.user_warning}}
                    ]
                },
                "images_count": {
                    "number": payload.images_count
                },
                "voice_seconds": {
                    "number": payload.voice_seconds
                },
                "social_presence": {
                    "select": {"name": payload.social_presence}
                },
            }
        )
        
        return SaveResponse(
            success=True,
            message="Analysis saved to Notion successfully",
            notion_page_id=page["id"]
        )
    
    except Exception as e:
        return SaveResponse(
            success=False,
            message=f"Error saving to Notion: {str(e)}",
            notion_page_id=None
        )
```

---

## 🚀 Step 4: Deploy to Render

### 4.1 Add Environment Variables to Render

1. Go to your Render service dashboard: https://dashboard.render.com
2. Click your service (Qubrix Backend)
3. Go to "Environment" tab
4. Add two new variables:
   - **Key**: `NOTION_API_KEY`  
     **Value**: `secret_xxxxx...` (paste your token from Step 2.1)
   - **Key**: `NOTION_DATABASE_ID`  
     **Value**: `your32chardb...` (from Step 2.2)
5. Click "Save Changes"
6. Service will redeploy automatically

### 4.2 Verify Deployment

Once service redeploys:
```
https://qubrix-q5ai.onrender.com/docs
```

Check if `/save` endpoint appears in Swagger docs.

---

## 📱 Step 5: Flutter Implementation

### 5.1 Create SaveBloc

Create file: `lib/BLoC/Save/save_bloc.dart`

```dart
import 'package:bloc/bloc.dart';
import '../../Models/save_request.dart';
import '../../Models/save_response.dart';
import '../../Services/api_service.dart';
import 'save_event.dart';
import 'save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  final ApiService apiService;

  SaveBloc({required this.apiService}) : super(const SaveInitial()) {
    on<SaveRequested>(_onSaveRequested);
  }

  Future<void> _onSaveRequested(
    SaveRequested event,
    Emitter<SaveState> emit,
  ) async {
    emit(const SaveLoading());

    try {
      final response = await apiService.saveToNotion(event.request);
      
      if (response.success) {
        emit(SaveSuccess(response.notionPageId ?? ""));
      } else {
        emit(SaveFailure(response.message));
      }
    } catch (e) {
      emit(SaveFailure("Error: ${e.toString()}"));
    }
  }
}
```

### 5.2 Create SaveEvent

Create file: `lib/BLoC/Save/save_event.dart`

```dart
import 'package:equatable/equatable.dart';
import '../../Models/save_request.dart';

abstract class SaveEvent extends Equatable {
  const SaveEvent();
}

class SaveRequested extends SaveEvent {
  final SaveRequest request;

  const SaveRequested(this.request);

  @override
  List<Object?> get props => [request];
}
```

### 5.3 Create SaveState

Create file: `lib/BLoC/Save/save_state.dart`

```dart
import 'package:equatable/equatable.dart';

abstract class SaveState extends Equatable {
  const SaveState();
}

class SaveInitial extends SaveState {
  const SaveInitial();

  @override
  List<Object?> get props => [];
}

class SaveLoading extends SaveState {
  const SaveLoading();

  @override
  List<Object?> get props => [];
}

class SaveSuccess extends SaveState {
  final String notionPageId;

  const SaveSuccess(this.notionPageId);

  @override
  List<Object?> get props => [notionPageId];
}

class SaveFailure extends SaveState {
  final String message;

  const SaveFailure(this.message);

  @override
  List<Object?> get props => [message];
}
```

### 5.4 Create Models

Create file: `lib/Models/save_request.dart`

```dart
import 'package:equatable/equatable.dart';

class SaveRequest extends Equatable {
  final double riskScore;
  final String riskLevel;
  final String analysis;
  final String impersonationMessage;
  final List<String> recommendations;
  final String userWarning;
  final int imagesCount;
  final int voiceSeconds;
  final String socialPresence;

  const SaveRequest({
    required this.riskScore,
    required this.riskLevel,
    required this.analysis,
    required this.impersonationMessage,
    required this.recommendations,
    required this.userWarning,
    required this.imagesCount,
    required this.voiceSeconds,
    required this.socialPresence,
  });

  Map<String, dynamic> toJson() {
    return {
      "risk_score": riskScore.toInt(),
      "risk_level": riskLevel,
      "analysis": analysis,
      "impersonation_message": impersonationMessage,
      "recommendations": recommendations,
      "user_warning": userWarning,
      "images_count": imagesCount,
      "voice_seconds": voiceSeconds,
      "social_presence": socialPresence,
    };
  }

  @override
  List<Object?> get props => [
    riskScore,
    riskLevel,
    analysis,
    impersonationMessage,
    recommendations,
    userWarning,
    imagesCount,
    voiceSeconds,
    socialPresence,
  ];
}
```

Create file: `lib/Models/save_response.dart`

```dart
import 'package:equatable/equatable.dart';

class SaveResponse extends Equatable {
  final bool success;
  final String message;
  final String? notionPageId;

  const SaveResponse({
    required this.success,
    required this.message,
    this.notionPageId,
  });

  factory SaveResponse.fromJson(Map<String, dynamic> json) {
    return SaveResponse(
      success: json["success"] as bool? ?? false,
      message: json["message"] as String? ?? "",
      notionPageId: json["notion_page_id"] as String?,
    );
  }

  @override
  List<Object?> get props => [success, message, notionPageId];
}
```

### 5.5 Update ApiService

Add this method to `lib/Services/api_service.dart`:

```dart
Future<SaveResponse> saveToNotion(SaveRequest request) async {
  final uri = Uri.parse("${AppConfig.baseUrl}/save");

  final res = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(request.toJson()),
  );

  if (res.statusCode != 200) {
    throw Exception("Save failed: ${res.statusCode} ${res.body}");
  }

  final json = jsonDecode(res.body) as Map<String, dynamic>;
  return SaveResponse.fromJson(json);
}
```

Don't forget to import `SaveRequest` and `SaveResponse` at top:
```dart
import '../Models/save_request.dart';
import '../Models/save_response.dart';
```

### 5.6 Update ResultScreen with Save Button

In `lib/Screens/ResultScreen/result_screen.dart`, add at the end (before final closing braces):

```dart
import 'package:flutter/material.dart';
import '../../BLoC/Save/save_bloc.dart';
import '../../BLoC/Save/save_event.dart';
import '../../BLoC/Save/save_state.dart';
import '../../Models/analyze_response.dart';
import '../../Models/save_request.dart';
import '../../Services/api_service.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';

class ResultScreen extends StatefulWidget {
  final AnalyzeResponse data;
  final int imagesCount;
  final int voiceSeconds;
  final String socialPresence;

  const ResultScreen({
    super.key,
    required this.data,
    required this.imagesCount,
    required this.voiceSeconds,
    required this.socialPresence,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late SaveBloc _saveBloc;

  @override
  void initState() {
    super.initState();
    _saveBloc = SaveBloc(apiService: ApiService());
  }

  @override
  void dispose() {
    _saveBloc.close();
    super.dispose();
  }

  void _saveToNotion() {
    final saveRequest = SaveRequest(
      riskScore: widget.data.riskScore,
      riskLevel: widget.data.riskLevel,
      analysis: widget.data.analysis,
      impersonationMessage: widget.data.impersonationMessage,
      recommendations: widget.data.recommendations,
      userWarning: widget.data.userWarning,
      imagesCount: widget.imagesCount,
      voiceSeconds: widget.voiceSeconds,
      socialPresence: widget.socialPresence,
    );

    _saveBloc.add(SaveRequested(saveRequest));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _saveBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Analysis Results",
            style: AppFonts.titleLarge.copyWith(color: AppColors.textAccent),
          ),
          backgroundColor: AppColors.bgPrimary,
        ),
        body: BlocListener<SaveBloc, SaveState>(
          listener: (context, state) {
            if (state is SaveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("✅ Saved to Notion!"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is SaveFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("❌ Save failed: ${state.message}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                // ... existing result display code ...

                const SizedBox(height: 24),
                BlocBuilder<SaveBloc, SaveState>(
                  builder: (context, state) {
                    final saving = state is SaveLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: saving ? null : _saveToNotion,
                        icon: saving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(
                          saving ? "Saving..." : "Save to Notion",
                          style: AppFonts.titleMedium,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### 5.7 Update UploadScreen Navigation

Modify `lib/Screens/UploadScreen/upload_screen.dart` to pass data to ResultScreen:

```dart
if (state is AnalyzeSuccess) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ResultScreen(
        data: state.data,
        imagesCount: images,
        voiceSeconds: voice,
        socialPresence: _socialPresence,
      ),
    ),
  );
}
```

---

## ✅ Testing Checklist

### Backend Testing

- [ ] `/analyze` endpoint still works
- [ ] `/save` endpoint appears in Swagger docs
- [ ] Test `/save` with sample data:

```bash
curl -X POST "https://qubrix-q5ai.onrender.com/save" \
  -H "Content-Type: application/json" \
  -d '{
    "risk_score": 65,
    "risk_level": "Medium",
    "analysis": "Test analysis",
    "impersonation_message": "Test message",
    "recommendations": ["Rec 1", "Rec 2"],
    "user_warning": "Test warning",
    "images_count": 20,
    "voice_seconds": 30,
    "social_presence": "medium"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "message": "Analysis saved to Notion successfully",
  "notion_page_id": "xxx..."
}
```

### Flutter Testing

- [ ] ResultScreen displays all data correctly
- [ ] "Save to Notion" button appears
- [ ] Click button → shows loading spinner
- [ ] After save → success snackbar "✅ Saved to Notion!"
- [ ] Check Notion database → new row appears with all fields populated

---

## 🎯 Summary

**Phase 4 Complete** when:
1. ✅ Notion database created with correct properties
2. ✅ Backend `/save` endpoint working on Render
3. ✅ Flutter "Save to Notion" button functional
4. ✅ Data persists to Notion database

**Next**: Phase 5 expanded testing + production polish

---

**Document Created**: 2026-03-29
