# Phase 5: End-to-End Testing Checklist

**Date**: 2026-03-29  
**Status**: Ready to Execute 🚀

---

## ✅ Pre-Flight Checklist

Before starting tests, verify these prerequisites:

- [ ] Backend running on Render: `https://qubrix-q5ai.onrender.com`
- [ ] Flutter project compiles: `flutter run` works without errors
- [ ] No compilation errors in console
- [ ] Internet connection active
- [ ] Device/emulator ready

---

## 🌐 Test 1: Backend Health Check (Render)

**Step 1:** Open a browser and navigate to:
```
https://qubrix-q5ai.onrender.com/health
```

**Expected Result:**
```json
{"status":"ok","message":"Qubrix backend is running"}
```

**Status:** ✅ Pass / ❌ Fail: `________`

**Notes:** 
- First request after inactivity may take ~50 seconds (Render free tier cold start)
- If fails: Backend may be down, check Render dashboard

---

## 📚 Test 2: Backend API Documentation

**Step 2:** Open Swagger documentation:
```
https://qubrix-q5ai.onrender.com/docs
```

**Expected Result:**
- Page loads with interactive API documentation
- Two endpoints visible: `/health` (GET) and `/analyze` (POST)

**Status:** ✅ Pass / ❌ Fail: `________`

**Notes:** Use this page to manually test `/analyze` if needed

---

## 📱 Test 3: Full Flutter App Flow

### Phase 3.1: Splash Screen
```
Step 1: Run flutter app
  $ cd d:\Projects\Qubrix\quantified_user_behavior_and_risk_intelligence_xpert
  $ flutter run

Step 2: Observe splash screen
```

**Expected Result:**
- Logo animates in from 0% to ~55% of animation
- Title "QUBRIX" fades in between 30-75%
- After 3 seconds → Automatically navigates to Connectivity Test screen

**Animation Duration:** ~3 seconds total  
**Status:** ✅ Pass / ❌ Fail: `________`

**Notes:** Feel free to close/kill and re-run app multiple times

---

### Phase 3.2: Connectivity Test Screen

**Step 3:** Arrive at Connectivity Test screen

**Expected Result:**
- Screen shows: status card, "Test /health" button, "Proceed to Analysis" button
- Status card shows: "Status: Not Tested"
- "Proceed to Analysis" button is DISABLED (greyed out)

**Status:** ✅ Pass / ❌ Fail: `________`

**Step 4:** Click "Test /health" button

**Expected Result:**
- Button shows loading spinner (2-3 seconds)
- Status card updates to: "Status: Connected ✓"
- Shows: "✓ Status: ok" and "✓ Message: Qubrix backend is running"
- "Proceed to Analysis" button becomes ENABLED

**Status:** ✅ Pass / ❌ Fail: `________`

**Notes:** 
- If this fails with timeout: Backend not responding
- If shows error: Check Firebase/Render connection URL in `AppConfig`

---

### Phase 3.3: Upload/Analyze Screen

**Step 5:** Click "Proceed to Analysis" button

**Expected Result:**
- Navigates to "Qubrix - Analyze" screen
- Three input fields visible:
  1. "Images count" (text field)
  2. "Voice seconds" (text field)
  3. "Social presence" (dropdown: low/medium/high)
- "Analyze Risk" button visible but in initial state

**Status:** ✅ Pass / ❌ Fail: `________`

---

### Phase 3.4: Input Validation Test

**Step 6:** Leave both text fields empty, click "Analyze Risk"

**Expected Result:**
- Snackbar appears: "Please enter valid numbers."
- App does NOT crash or freeze

**Status:** ✅ Pass / ❌ Fail: `________`

---

### Phase 3.5: Normal Risk Analysis (Test Case 1)

**Step 7:** Enter test values:
```
Images count: 20
Voice seconds: 30
Social presence: low
```

**Expected Result:**
- All fields filled
- "Analyze Risk" button is clickable

**Step 8:** Click "Analyze Risk" button

**Expected Result:**
- Button shows loading spinner
- App makes API call to `https://qubrix-q5ai.onrender.com/analyze`
- Response received within 5 seconds
- Button spinner disappears

**Expected Risk Level:** LOW (risk_score should be ≤34)

**Status:** ✅ Pass / ❌ Fail: `________`

---

### Phase 3.6: Result Screen Display

**Step 9:** Verify Result screen displays all components

**Expected Result:**
```
✅ Risk Score display (XX/100, in large text)
✅ Progress bar (cyan colored)
✅ Risk Level chip (color: green for Low)
✅ Analysis section with text
✅ Impersonation Risk box with message
✅ Recommendations (4 bullet points)
✅ User Warning text
✅ All text uses Orbitron font (geometric, tech style)
✅ Colors: Gold & Cyan accents on dark background
```

**Status:** ✅ Pass / ❌ Fail: `________`

**Screenshot**: Capture for documentation `________`

---

### Phase 3.7: High Risk Test Case

**Step 10:** Go back to Upload screen (press back/navigate)

Expected: Screen navigates back successfully

**Step 11:** Enter high-risk values:
```
Images count: 500 (max)
Voice seconds: 300 (max)
Social presence: high
```

**Expected Result:**
- Risk score clamped to 100
- Risk level: "High"
- Result screen shows red/error styling for High risk
- Recommendations updated for high risk

**Status:** ✅ Pass / ❌ Fail: `________`

---

### Phase 3.8: Medium Risk Test Case

**Step 12:** Try medium values:
```
Images count: 50
Voice seconds: 60
Social presence: medium
```

**Expected Result:**
- Risk score: between 35-69
- Risk level: "Medium"
- Chip color: orange/yellow
- Standard recommendations

**Status:** ✅ Pass / ❌ Fail: `________`

---

## 🎨 Design System Verification

**Check throughout all tests:**

- [ ] All text uses Orbitron font (consistent, geometric)
- [ ] Colors:
  - [ ] Background: Dark brown (#1A1612)
  - [ ] Accents: Gold (#C99222) on buttons/titles
  - [ ] Secondary: Cyan (#00D9FF) on progress indicators
- [ ] All buttons have gold background when enabled
- [ ] Input fields have gold borders when focused
- [ ] No default Material colors (grey, blue, etc.)
- [ ] Consistent spacing/padding throughout

**Status:** ✅ Pass / ❌ Fail: `________`

---

## 🐛 Error Handling Tests

### Test Error 1: Invalid Network Request

**Step:** Manually break backend URL in `AppConfig`:
```dart
// Temporarily change to:
static const String baseUrl = "https://invalid-url.com";
```

Run app again, try to analyze.

**Expected Result:**
- Error message displayed on Upload screen
- App doesn't crash
- Can still navigate back

**Status:** ✅ Pass / ❌ Fail: `________`

**Then restore:** Fix the URL back to correct value

---

### Test Error 2: Backend Timeout

**Step:** On Render dashboard, temporarily stop the backend service

Try to test connectivity or analyze.

**Expected Result:**
- App shows timeout error (~30 seconds)
- Can still navigate/interact
- No hard crash

**Status:** ✅ Pass / ❌ Fail: `________`

**Then restore:** Restart Render backend

---

## 📊 Performance Notes

| Metric | Expected | Actual |
|--------|----------|--------|
| Splash Duration | ~3 sec | `____` sec |
| /health response | <2 sec | `____` sec |
| /analyze response | <5 sec | `____` sec |
| First Render cold start | <10 sec | `____` sec |
| App restart (hot reload) | <5 sec | `____` sec |

---

## 🎯 Final Summary

### All Tests Passed? ✅

**Total Passed:** `____ / ____`

If **ALL** tests pass:
- ✅ **Phase 5 COMPLETE**
- ✅ Ready for Phase 4 (Notion `/save` implementation)
- ✅ App is production-ready for basic testing

---

### Issues Found? 

**Issue Checklist:**

1. **Compile Error?**
   - [ ] Run `flutter clean`
   - [ ] Run `flutter pub get`
   - [ ] Run `flutter run` again

2. **Backend Connection Error?**
   - [ ] Check Render is not down: https://status.render.com
   - [ ] Verify `AppConfig.baseUrl` is correct
   - [ ] Check internet connection

3. **Navigation Issue?**
   - [ ] Check route names in `main.dart`
   - [ ] Run `flutter clean` + `flutter run`
   - [ ] Check Navigator code uses `pushNamed()` correctly

4. **API Response Mismatch?**
   - [ ] Check `/docs` on Render for expected schema
   - [ ] Verify JSON parsing in `AnalyzeResponse.fromJson()`
   - [ ] Check Python backend calculation logic

**Details of issues found:**
```
________________________________________
________________________________________
________________________________________
```

---

## 📝 Testing Log

**Tester Name:** `____________`  
**Date Tested:** `2026-03-29`  
**Pass Rate:** `____ %`  
**Time Spent:** `____ minutes`  

**Recommendations:**
```
________________________________________
________________________________________
________________________________________
```

---

## 🚀 Next Step: Phase 4 (Notion Integration)

Once Phase 5 testing is complete, proceed to:

**Phase 4: Implement `/save` endpoint**

Steps:
1. Set up Notion database
2. Add environment variables to Render
3. Implement `/save` endpoint in FastAPI
4. Add "Save to Notion" button in ResultScreen
5. Implement SaveBloc in Flutter

---

**Document Version:** 1.0  
**Last Updated:** 2026-03-29  
**Status:** Ready to Execute 🚀
