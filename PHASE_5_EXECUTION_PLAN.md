# Phase 5: End-to-End Testing & Deployment Polish
**Execution Plan**  
**Date**: April 9, 2026  
**Status**: 🚀 Ready to Execute

---

## 📋 Quick Start

### Prerequisites (Before Starting)
- [ ] Internet connection active  
- [ ] Browser ready for backend testing  
- [ ] Flutter emulator/device ready  
- [ ] Terminal ready in project directories  

### Tech Stack Verification
```
Backend:  FastAPI on Render (https://qubrix-q5ai.onrender.com)
Frontend: Flutter 3.11.0+ with BLoC 8.1.4
DB:       Notion (with integration configured)
```

---

## 🌐 SECTION A: Backend Infrastructure Tests

### Test A.1: Backend Health Check
**Objective:** Verify backend is running on Render

**Steps:**
1. Open browser → Go to: `https://qubrix-q5ai.onrender.com/health`
2. Wait for response (may take up to 50 seconds on cold start)
3. Check response

**Expected Response:**
```json
{
  "status": "ok",
  "message": "Qubrix backend is running"
}
```

**Result:** 
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test A.2: Swagger API Documentation
**Objective:** Verify all endpoints are documented

**Steps:**
1. Open browser → Go to: `https://qubrix-q5ai.onrender.com/docs`
2. Check if page loads
3. Verify endpoints visible:
   - `/health` (GET)
   - `/analyze` (POST)
   - `/save` (POST)

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test A.3: Manual API Test - /analyze (Swagger)
**Objective:** Test `/analyze` endpoint directly from Swagger

**Steps:**
1. In Swagger docs, expand POST `/analyze`
2. Click "Try it out"
3. Enter test data:
```json
{
  "images_count": 20,
  "voice_seconds": 30,
  "social_presence": "low"
}
```
4. Click "Execute"
5. Check response

**Expected Response:**
```json
{
  "risk_score": <number 0-100>,
  "risk_level": "Low|Medium|High",
  "analysis": "...",
  "impersonation_message": "...",
  "recommendations": [...],
  "user_warning": "..."
}
```

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test A.4: Manual API Test - /save (Swagger)
**Objective:** Test `/save` endpoint with Notion integration

**Steps:**
1. In Swagger docs, expand POST `/save`
2. Click "Try it out"
3. Enter test data:
```json
{
  "risk_score": 55,
  "risk_level": "Medium",
  "analysis": "Test analysis from Phase 5",
  "timestamp": "2026-04-09T10:00:00+05:30"
}
```
4. Click "Execute"
5. Check response
6. **Verify in Notion DB**: Log in to Notion → Check database for new entry

**Expected Response:**
```json
{
  "success": true,
  "message": "Saved to Notion",
  "notion_page_id": "..."
}
```

**Result:**
- ✅ Pass (saved to Notion)  
- ❌ Fail: ________________

**Notion Entry Created:** ✅ / ❌  
**Notes:** 
- _____________________________________________________

---

## 📱 SECTION B: Flutter App Tests

### Test B.1: Build & Compilation
**Objective:** Ensure Flutter project compiles without errors

**Steps:**
1. Terminal → Navigate to Flutter project:
```bash
cd d:\Projects\Qubrix\quantified_user_behavior_and_risk_intelligence_xpert
```

2. Get dependencies:
```bash
flutter pub get
```

3. Analyze code:
```bash
flutter analyze
```

4. Build (optional):
```bash
flutter build apk --release
# OR for iOS:
flutter build ios --release
```

**Result:**
- ✅ Pass (no errors)  
- ❌ Fail: ________________

**Errors Found:** 
- _____________________________________________________
- _____________________________________________________

---

### Test B.2: Splash Screen Animation
**Objective:** Verify splash screen displays correctly (3 seconds)

**Steps:**
1. Terminal → Start app:
```bash
flutter run
```

2. Observe splash screen for ~3 seconds
3. Check components:
   - Logo animates in from top
   - "QUBRIX" title fades in
   - Animation smooth and centered

**Expected Result:**
- Logo visible at ~55% of screen
- Title "QUBRIX" appears between 30-75% animation
- After 3 seconds → Auto-navigates to Connectivity Test screen

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test B.3: Connectivity Test Screen
**Objective:** Verify /health check integration

**Steps:**
1. App lands on Connectivity Test screen
2. Check initial state:
   - Status card shows: "Status: Not Tested"
   - "Test /health" button visible
   - "Proceed to Analysis" button DISABLED (greyed)

3. Click "Test /health" button
4. Observe loading (2-3 seconds)
5. Check result:
   - Status updates to: "Status: Connected ✓"
   - Shows: "✓ Status: ok"
   - Shows: "✓ Message: Qubrix backend is running"
   - "Proceed to Analysis" button becomes ENABLED

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test B.4: Navigation to Upload Screen
**Objective:** Verify screen navigation

**Steps:**
1. Click "Proceed to Analysis" button
2. App navigates to Upload screen

**Expected Result:**
- Screen title: "Qubrix - Analyze"
- Three input fields visible:
  - "Images count" (TextFormField)
  - "Voice seconds" (TextFormField)
  - "Social presence" (Dropdown)
- "Analyze Risk" button visible

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test B.5: Input Validation
**Objective:** Verify form validation

**Steps:**
1. Leave both text fields empty
2. Click "Analyze Risk"
3. Check for error

**Expected Result:**
- Snackbar shows: "Please enter valid numbers."
- App does NOT crash

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

## 🧪 SECTION C: Risk Analysis Tests

### Test C.1: LOW Risk Test Case
**Objective:** Test low-risk scenario

**Test Data:**
```
Images count: 20
Voice seconds: 30
Social presence: low
```

**Steps:**
1. Fill in all fields
2. Click "Analyze Risk"
3. Observe loading spinner
4. Wait for response (~5 seconds)
5. Verify Result screen

**Expected Result:**
- Risk Score: ≤ 34 (LOW)
- Risk Level: "Low"
- Chip color: Green
- Result screen displays all components

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Actual Risk Score:** _________  
**Notes:** 
- _____________________________________________________

---

### Test C.2: MEDIUM Risk Test Case
**Objective:** Test medium-risk scenario

**Test Data:**
```
Images count: 50
Voice seconds: 60
Social presence: medium
```

**Steps:**
1. Navigate back to Upload screen
2. Fill in fields
3. Click "Analyze Risk"
4. Wait for response
5. Verify Result screen

**Expected Result:**
- Risk Score: 35-69 (MEDIUM)
- Risk Level: "Medium"
- Chip color: Orange
- Recommendations include "Treat unexpected messages..." message

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Actual Risk Score:** _________  
**Notes:** 
- _____________________________________________________

---

### Test C.3: HIGH Risk Test Case
**Objective:** Test high-risk scenario

**Test Data:**
```
Images count: 500
Voice seconds: 300
Social presence: high
```

**Steps:**
1. Navigate back to Upload screen
2. Fill in fields (or max values)
3. Click "Analyze Risk"
4. Wait for response
5. Verify Result screen

**Expected Result:**
- Risk Score: 70-100 (HIGH, typically clamped at 100)
- Risk Level: "High"
- Chip color: Red
- Analysis mentions high risk
- Recommendations include critical warning first

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Actual Risk Score:** _________  
**Notes:** 
- _____________________________________________________

---

## 💾 SECTION D: Notion Save Integration Tests

### Test D.1: Save to Notion Button
**Objective:** Verify "Save to Notion" button on Result screen

**Steps:**
1. From any Result screen, scroll to bottom
2. Check for "Save to Notion" button
3. Button should be enabled

**Result:**
- ✅ Pass (button visible & enabled)  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test D.2: Successful Save to Notion
**Objective:** Test end-to-end save flow

**Steps:**
1. On Result screen (from any risk level)
2. Click "Save to Notion" button
3. Observe loading spinner (2-3 seconds)
4. Check for success snackbar
5. Verify in Notion:
   - Log in to Notion
   - Open Qubrix database
   - Check for new entry with:
     - Title: "{Risk Level} Risk - {timestamp}"
     - Risk Score: (numeric)
     - Risk Level: (select option)
     - Full analysis text

**Expected Result:**
- Snackbar shows: "Saved to Notion"
- No errors
- Entry appears in Notion DB within 5 seconds

**Result:**
- ✅ Pass (saved to Notion)  
- ❌ Fail: ________________

**Notion Page ID:** _________________  
**Notes:** 
- _____________________________________________________

---

### Test D.3: Save Error Handling
**Objective:** Test error handling when save fails

**Steps:**
1. (Optional) Temporarily change backend URL in `AppConfig` to invalid URL
2. On Result screen, click "Save to Notion"
3. Observe error handling

**Expected Result:**
- After 2-3 seconds, error snackbar appears
- Shows error message (not blank)
- App doesn't crash

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Error Message:** _____________________________________________________

---

## 🎨 SECTION E: Design System Verification

### Test E.1: Orbitron Font Consistency
**Objective:** Verify all text uses Orbitron font

**Check Locations:**
- [ ] Splash screen title "QUBRIX"
- [ ] All buttons
- [ ] All input field labels
- [ ] Result screen titles
- [ ] Risk score display
- [ ] Chip text
- [ ] Snackbar text

**Observation:**
- Font is geometric, futuristic, consistent throughout
- No default Material fonts

**Result:**
- ✅ Pass (all Orbitron)  
- ❌ Fail: Some text missing ________________

**Notes:** 
- _____________________________________________________

---

### Test E.2: Color Scheme Verification
**Objective:** Verify dark theme colors

**Color Checks:**

| Component | Expected Color | Actual | ✅/❌ |
|-----------|----------------|--------|-------|
| Background | Dark Brown (#1A1612) | _____ | ___ |
| Primary Accents | Gold (#C99222) | _____ | ___ |
| Secondary Accents | Cyan (#00D9FF) | _____ | ___ |
| Progress Bar | Cyan | _____ | ___ |
| Buttons (enabled) | Gold background | _____ | ___ |
| Risk Chip (Low) | Green | _____ | ___ |
| Risk Chip (Medium) | Orange | _____ | ___ |
| Risk Chip (High) | Red | _____ | ___ |
| Text (primary) | Light gray | _____ | ___ |

**Overall Result:**
- ✅ Pass (all correct)  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test E.3: Layout & Spacing
**Objective:** Verify consistent layout

**Checks:**
- [ ] Padding between elements (16dp standard)
- [ ] Buttons full-width or properly sized
- [ ] Input fields properly aligned
- [ ] No overlapping content
- [ ] Scrollable when needed
- [ ] Responsive on different screen sizes (if testing multiple devices)

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

## ⚡ SECTION F: Performance Tests

### Test F.1: Splash Screen Duration
**Objective:** Measure splash animation duration

**Measurement:**
- Start time: ___________
- Navigation time: ___________
- **Duration:** _________ seconds

**Expected:** ~3 seconds  
**Result:** ✅ Pass / ❌ Fail

---

### Test F.2: /health Response Time
**Objective:** Measure API response time for connectivity test

**Measurement:**
- Request time: ___________
- Response time: ___________
- **Duration:** _________ seconds

**Expected:** < 2 seconds (or cold start < 50 seconds)  
**Result:** ✅ Pass / ❌ Fail

---

### Test F.3: /analyze Response Time
**Objective:** Measure risk analysis API response time

**Measurement:**
- Request time: ___________
- Response time: ___________
- **Duration:** _________ seconds

**Expected:** < 5 seconds  
**Result:** ✅ Pass / ❌ Fail

---

### Test F.4: /save Response Time
**Objective:** Measure Notion save API response time

**Measurement:**
- Request time: ___________
- Response time: ___________
- **Duration:** _________ seconds

**Expected:** < 3 seconds  
**Result:** ✅ Pass / ❌ Fail

---

## 🐛 SECTION G: Error Handling & Edge Cases

### Test G.1: Network Timeout
**Objective:** Test app behavior with no internet

**Steps:**
1. (Disconnect internet OR use network throttling)
2. Try to test connectivity or analyze
3. Wait for timeout (~30 seconds)

**Expected Result:**
- Error message or timeout snackbar appears
- App remains responsive
- Can navigate back
- No hard crash

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

### Test G.2: Invalid Input Edge Cases
**Objective:** Test boundary conditions

**Test Cases:**

| Input | Expected | Result |
|-------|----------|--------|
| Images: -1 | Error/rejected | ✅/❌ |
| Images: 501 | Clamped or error | ✅/❌ |
| Voice: -1 | Error/rejected | ✅/❌ |
| Voice: 3601 | Clamped or error | ✅/❌ |
| Empty dropdown | Error shown | ✅/❌ |

---

### Test G.3: Rapid Navigation
**Objective:** Test rapid back/forward navigation

**Steps:**
1. Navigate rapidly between screens (back/forward/back)
2. During loading, click back button multiple times
3. Try switching dropdown values quickly

**Expected Result:**
- App remains stable
- No crashes or freezes
- Proper state management (BLoC handles cancellations)

**Result:**
- ✅ Pass  
- ❌ Fail: ________________

**Notes:** 
- _____________________________________________________

---

## ✅ FINAL SUMMARY

### Overall Status
- **Backend Tests (A):** ___ / 4 passed
- **Flutter Build (B.1):** ✅ / ❌
- **UI/Navigation Tests (B):** ___ / 4 passed
- **Risk Analysis Tests (C):** ___ / 3 passed
- **Notion Integration (D):** ___ / 3 passed
- **Design System (E):** ___ / 3 passed
- **Performance (F):** ___ / 4 passed
- **Error Handling (G):** ___ / 3 passed

### Critical Issues Found
1. _____________________________________________________
2. _____________________________________________________
3. _____________________________________________________

### Minor Issues Found
1. _____________________________________________________
2. _____________________________________________________

### Recommendations for Deployment
- [ ] All critical tests passing
- [ ] No hard crashes
- [ ] Performance within acceptable range
- [ ] Design matches specifications
- [ ] All 3 endpoints working (health, analyze, save)
- [ ] Notion integration confirmed

### Go/No-Go Decision
- **READY FOR PRODUCTION:** ✅ / ❌
- **Reason:** _________________________________________________________________

---

## 📝 Sign-Off

**Testing Completed By:** ________________  
**Date Completed:** ________________  
**Version Tested:** ________________  
**Build ID:** ________________  
**Notes:** ________________________________________________________________

---

**Next Steps After Phase 5:**
- [ ] Deploy to app stores (Google Play, Apple App Store)
- [ ] Post-deployment monitoring
- [ ] User feedback collection
- [ ] Bug fix follow-up
- [ ] Documentation finalization
