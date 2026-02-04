# Quick Flutter Installation & Chrome Testing Guide

## Installation Steps

### 1. Download Flutter
- Go to: https://docs.flutter.dev/get-started/install/windows
- Click "Download Flutter SDK" (blue button)
- Save the zip file

### 2. Extract to C:\src
Once downloaded, extract the zip file:
- Right-click the downloaded zip file
- Choose "Extract All..."
- Set destination to: `C:\src`
- Make sure it creates `C:\src\flutter` (not `C:\src\flutter_windows...`)

### 3. Add to PATH
**Option A - GUI (Recommended):**
1. Press `Windows Key` and type "environment"
2. Click "Edit the system environment variables"
3. Click "Environment Variables" button
4. Under "User variables", select "Path" → "Edit"
5. Click "New"
6. Add: `C:\src\flutter\bin`
7. Click OK on all windows

**Option B - PowerShell:**
```powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\src\flutter\bin", "User")
```

### 4. RESTART PowerShell
**CRITICAL**: Close PowerShell completely and open a NEW window

### 5. Verify Installation
```powershell
flutter doctor
```

You should see Flutter version info!

---

## Running App in Chrome

Once Flutter is installed:

```powershell
# Navigate to app
cd c:\Users\cshan\.gemini\antigravity\playground\neon-magnetar\dictionary_app

# Get dependencies
flutter pub get

# Enable web support (first time only)
flutter config --enable-web

# Run in Chrome
flutter run -d chrome
```

**The app will automatically open in Chrome!** 🎉

---

## What You'll See in Chrome

When the app launches:
1. ✅ Dictionary app loads
2. ✅ See 20 pre-loaded sample words
3. ✅ Search bar at top
4. ✅ Theme toggle (sun/moon icon)
5. ✅ + button to add words

---

## Quick Test Checklist

Once running in Chrome:
- [ ] Click theme toggle (top-right) → switches dark/light
- [ ] Type "api" in search → filters to matching words
- [ ] Click + button → opens add word form
- [ ] Add a test word → appears in list
- [ ] Click edit icon on a word → opens edit form
- [ ] Click delete icon → shows confirmation dialog

---

## Troubleshooting

**"flutter: command not found" after adding to PATH**
- Solution: Did you restart PowerShell? Close it completely and open NEW window

**"Chrome not found"**
```powershell
flutter config --enable-web
# Then restart
```

**"No devices available"**
```powershell
# List devices
flutter devices

# If Chrome not listed, install Chrome browser
```

---

## Time Estimate
- Download: 5 mins
- Extract & PATH: 3 mins
- First run: 2 mins
- **Total: ~10 minutes to see your app running!**
