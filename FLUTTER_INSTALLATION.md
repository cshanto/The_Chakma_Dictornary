# Flutter Installation Guide for Windows

## Step-by-Step Installation

### 1. Download Flutter SDK

**Option A: Direct Download (Recommended)**
1. Go to: https://docs.flutter.dev/get-started/install/windows
2. Click "Download Flutter SDK" (latest stable version)
3. Extract the zip file to `C:\src\flutter`
   - **IMPORTANT**: Do NOT install to `C:\Program Files\` (requires special permissions)

**Option B: Using Git**
```powershell
cd C:\src
git clone https://github.com/flutter/flutter.git -b stable
```

---

### 2. Add Flutter to PATH

**GUI Method (Easiest):**
1. Press `Windows Key` and search for "Environment Variables"
2. Click "Edit the system environment variables"
3. Click "Environment Variables" button
4. Under "User variables", find "Path" and click "Edit"
5. Click "New" and add: `C:\src\flutter\bin`
6. Click "OK" on all dialogs
7. **RESTART PowerShell** (important!)

**PowerShell Method (Advanced):**
```powershell
# Add to current session (temporary)
$env:Path += ";C:\src\flutter\bin"

# Add permanently to user PATH
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\src\flutter\bin", "User")
```

---

### 3. Verify Installation

Open a **NEW** PowerShell window and run:
```powershell
flutter --version
```

You should see output like:
```
Flutter 3.x.x • channel stable
```

---

### 4. Run Flutter Doctor

```powershell
flutter doctor
```

This checks your installation. You'll see:
- ✓ Flutter (should be checked)
- ✗ Android toolchain (optional - for Android builds)
- ✗ Chrome (optional - for web testing)
- ✗ Visual Studio (optional - for Windows builds)

**You only need Flutter checked to get started with web testing!**

---

### 5. Accept Android Licenses (Optional)

If you want Android support:
```powershell
flutter doctor --android-licenses
```

Press `y` to accept all licenses.

---

## Quick Test After Installation

```powershell
# Navigate to your app
cd c:\Users\cshan\.gemini\antigravity\playground\neon-magnetar\dictionary_app

# Get dependencies
flutter pub get

# Run on Chrome (no phone needed!)
flutter run -d chrome
```

---

## Troubleshooting

### "flutter: command not found" after installation
- **Solution**: Restart PowerShell/Terminal completely
- Verify PATH: `echo $env:Path` should contain `flutter\bin`

### "Unable to find git in your PATH"
- Install Git: https://git-scm.com/download/win
- Or ignore if only using Flutter

### Chrome not detected
- Install Chrome: https://www.google.com/chrome/
- Or use: `flutter config --enable-web` then restart

---

## Download Links

- **Flutter SDK**: https://docs.flutter.dev/get-started/install/windows
- **Git for Windows**: https://git-scm.com/download/win
- **Android Studio** (for Android development): https://developer.android.com/studio
- **Chrome Browser**: https://www.google.com/chrome/

---

## What You'll Need

### Minimum (for web testing):
- Flutter SDK (~500MB)
- Chrome browser

### For Android builds:
- Android Studio (~3GB)
- Android SDK
- Android device or emulator

### For iOS builds:
- macOS (required)
- Xcode
- Apple Developer account

---

## Alternative: Use Flutter Online

If you don't want to install Flutter right now, you can test the code structure online:

**DartPad (Online Flutter Editor)**
- Visit: https://dartpad.dev/
- Note: Limited functionality, no database support

---

## Estimated Installation Time

- Download Flutter: ~5 minutes
- Extract & Configure PATH: ~2 minutes
- Run flutter doctor: ~1 minute
- **Total**: ~10 minutes

---

## Next Steps After Installation

1. ✅ Verify: `flutter --version`
2. ✅ Check: `flutter doctor`
3. ✅ Navigate: `cd dictionary_app`
4. ✅ Dependencies: `flutter pub get`
5. ✅ Run: `flutter run -d chrome`

**Your app will open in Chrome!** 🎉
