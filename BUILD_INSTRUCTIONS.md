# Flutter Dictionary App - Build Instructions

## Quick Start Guide

### Prerequisites Check
Before building, verify Flutter installation:
```bash
flutter doctor
```

All checkmarks should be green for your target platform (Android/iOS).

---

## 🤖 Building for Android

### Option 1: Build APK (Recommended for Testing)

**Step 1**: Navigate to project directory
```bash
cd dictionary_app
```

**Step 2**: Clean previous builds
```bash
flutter clean
flutter pub get
```

**Step 3**: Build release APK
```bash
flutter build apk --release
```

**Output**: `build/app/outputs/flutter-apk/app-release.apk`

**Step 4**: Install on device
```bash
# Connect your Android device via USB (enable USB debugging)
# Or start an emulator
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Option 2: Build App Bundle (For Google Play Store)

```bash
flutter build appbundle --release
```

**Output**: `build/app/outputs/bundle/release/app-release.aab`

Upload this `.aab` file to Google Play Console.

### Android Build Sizes (Approximate)
- APK: ~20-25 MB
- App Bundle: ~15-20 MB

---

## 🍎 Building for iOS

**Requirements**: macOS with Xcode installed

### Step 1: Install CocoaPods (if not installed)
```bash
sudo gem install cocoapods
```

### Step 2: Navigate to project
```bash
cd dictionary_app
```

### Step 3: Install iOS dependencies
```bash
cd ios
pod install
cd ..
```

### Step 4: Build for iOS
```bash
flutter build ios --release
```

### Step 5: Open in Xcode for signing
```bash
open ios/Runner.xcworkspace
```

In Xcode:
1. Select your development team
2. Configure signing certificates
3. Select target device or "Any iOS Device"
4. Product → Archive
5. Distribute App → App Store Connect / Ad Hoc / Development

### iOS Distribution Options

**For Testing (No App Store)**:
- **Ad Hoc**: Share with up to 100 devices (requires UDIDs)
- **Development**: Install on registered development devices

**For App Store**:
- Requires Apple Developer Program ($99/year)
- Submit through App Store Connect

---

## 🔧 Advanced Build Options

### Build with Specific Target

```bash
# Android - specific architecture
flutter build apk --target-platform android-arm64

# iOS - specific configuration
flutter build ios --release --no-codesign
```

### Debug vs Release

**Debug Build** (for development):
```bash
flutter run
```

**Release Build** (optimized):
```bash
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

### Build for Multiple Architectures (Android)

```bash
# Build split APKs per architecture (smaller files)
flutter build apk --split-per-abi

# Outputs:
# - app-armeabi-v7a-release.apk
# - app-arm64-v8a-release.apk  
# - app-x86_64-release.apk
```

---

## 📊 Verifying Build

### Check App Size
```bash
# Android
flutter build apk --analyze-size

# iOS
flutter build ios --analyze-size
```

### Test Release Build
```bash
# Android
flutter run --release

# iOS (on simulator)
flutter run --release -d "iPhone 14"
```

---

## 🚨 Common Build Issues & Solutions

### Android Issues

**Issue**: "Gradle build failed"
```bash
# Solution
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

**Issue**: "SDK location not found"
```bash
# Create local.properties in android/ folder
echo "sdk.dir=/path/to/Android/sdk" > android/local.properties
```

### iOS Issues

**Issue**: "Pod install failed"
```bash
# Solution
cd ios
rm Podfile.lock
rm -rf Pods
pod install --repo-update
cd ..
```

**Issue**: "Code signing error"
- Open `ios/Runner.xcworkspace` in Xcode
- Select Runner → Signing & Capabilities
- Select your team and enable "Automatically manage signing"

---

## 📦 Distribution

### Android

**Google Play Store**:
1. Build app bundle: `flutter build appbundle --release`
2. Create Google Play Developer account ($25 one-time)
3. Upload `.aab` file to Play Console
4. Complete store listing and publish

**Direct Distribution**:
- Share `app-release.apk` file
- Users can install directly (enable "Unknown Sources")

### iOS

**App Store**:
1. Archive in Xcode
2. Upload to App Store Connect
3. Complete app review process
4. Publish to App Store

**TestFlight** (Beta Testing):
- Upload build to App Store Connect
- Add beta testers
- Distribute via TestFlight app

---

## ⚡ Build Performance Tips

### Speed up builds

```bash
# Use cached builds
flutter build apk --release --cached

# Parallel execution
flutter build apk --release --preview-dart-2
```

### Reduce app size

```bash
# Enable code shrinking (Android)
flutter build apk --release --shrink

# Obfuscate code
flutter build apk --obfuscate --split-debug-info=debug-info/
```

---

## ✅ Final Checklist

### Before Building for Production:

- [ ] Remove debug code
- [ ] Update version in `pubspec.yaml`
- [ ] Test on real devices
- [ ] Verify offline functionality
- [ ] Test both themes
- [ ] Check all CRUD operations
- [ ] Update app icons (if needed)
- [ ] Add proper splash screen (if needed)
- [ ] Review permissions in `AndroidManifest.xml` / `Info.plist`

---

## 📱 Install Flutter (If Not Installed)

### Windows
```powershell
# Download from: https://docs.flutter.dev/get-started/install/windows
# Extract zip to C:\src\flutter
# Add to PATH: C:\src\flutter\bin
flutter doctor
```

### macOS
```bash
# Using git
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
# Add to ~/.zshrc or ~/.bashrc
flutter doctor
```

### Linux
```bash
sudo snap install flutter --classic
flutter doctor
```

---

**Need Help?** 
- Flutter Docs: https://docs.flutter.dev
- Flutter Community: https://flutter.dev/community
