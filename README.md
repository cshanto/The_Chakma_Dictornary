# Dictionary App

A beautiful cross-platform dictionary application built with Flutter, optimized for both iOS and Android with offline functionality and dark/light theme support.

## ✨ Features

- 📱 **Cross-Platform**: Single codebase for both iOS and Android
- 📴 **Offline First**: Works completely offline with local database
- 🌓 **Dark & Light Themes**: Toggle between beautiful themes
- 🔍 **Search**: Fast search across words and definitions
- ➕ **CRUD Operations**: Add, edit, and delete dictionary entries
- 💾 **Persistent Storage**: Data saved using Hive (fastest NoSQL database)
- 🎨 **Modern UI**: Material Design 3 with smooth animations
- 📚 **Pre-loaded Content**: 20 sample words included

## 🚀 Technology Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **Database**: Hive (NoSQL)
- **State Management**: Provider
- **Design**: Material Design 3

## 📋 Prerequisites

Before running the app, ensure you have:

1. **Flutter SDK** (3.0.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   
2. **For Android Development**:
   - Android Studio with Android SDK
   - Android device/emulator
   
3. **For iOS Development** (macOS only):
   - Xcode 14+
   - iOS Simulator or physical iOS device
   - CocoaPods

## 🛠️ Installation & Setup

### 1. Install Flutter

**Windows:**
```powershell
# Download Flutter SDK from https://flutter.dev
# Extract and add to PATH
# Verify installation
flutter doctor
```

**macOS/Linux:**
```bash
# Download Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
```

### 2. Get Dependencies

Navigate to the project directory and run:
```bash
cd dictionary_app
flutter pub get
```

### 3. Run the App

**For Android:**
```bash
# Connect Android device or start emulator
flutter devices
flutter run
```

**For iOS (macOS only):**
```bash
# Open iOS Simulator or connect iOS device
open -a Simulator
flutter run
```

## 📦 Building for Production

### Android APK

```bash
# Build release APK
flutter build apk --release

# Output location:
# build/app/outputs/flutter-apk/app-release.apk
```

**Install APK on Android device:**
```bash
# Transfer APK to device and install
# Or use adb
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

### iOS (macOS only)

```bash
# Build iOS app
flutter build ios --release

# Open in Xcode for signing and distribution
open ios/Runner.xcworkspace
```

**Note**: iOS distribution requires:
- Apple Developer Account ($99/year)
- Proper code signing certificates
- Device provisioning profiles

## 📱 App Usage

### Adding a Word
1. Tap the **+** floating button
2. Enter word, definition, and optional example
3. Tap the **✓** or **Save** button

### Searching
1. Use the search bar at the top
2. Type to filter words and definitions in real-time

### Editing a Word
1. Tap the **edit icon** on any word card
2. Modify the fields
3. Tap **Update Word**

### Deleting a Word
1. Tap the **delete icon** on any word card
2. Confirm deletion in the dialog

### Changing Theme
- Tap the **sun/moon icon** in the app bar to toggle themes

## 🗂️ Project Structure

```
dictionary_app/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── models/
│   │   ├── dictionary_entry.dart    # Data model
│   │   └── dictionary_entry.g.dart  # Generated Hive adapter
│   ├── services/
│   │   └── database_service.dart    # Database operations
│   ├── providers/
│   │   └── theme_provider.dart      # Theme state management
│   ├── screens/
│   │   ├── home_screen.dart         # Main screen
│   │   └── add_edit_screen.dart     # Add/Edit form
│   ├── widgets/
│   │   └── dictionary_card.dart     # Word card widget
│   └── theme/
│       └── app_theme.dart           # Theme definitions
├── android/                          # Android-specific files
├── ios/                             # iOS-specific files
└── pubspec.yaml                     # Dependencies
```

## 🎨 Customization

### Adding More Sample Words

Edit `lib/services/database_service.dart` in the `_addSampleData()` method:

```dart
DictionaryEntry(
  word: 'Your Word',
  definition: 'The definition',
  example: 'An example sentence.',
),
```

### Changing Theme Colors

Edit `lib/theme/app_theme.dart` to customize colors:

```dart
static const Color lightPrimary = Color(0xFF6200EE); // Your color
```

## 🐛 Troubleshooting

### "Flutter not found"
- Ensure Flutter is added to your PATH
- Run `flutter doctor` to diagnose issues

### "Gradle build failed" (Android)
- Update Android SDK
- Check `android/build.gradle` settings
- Clear cache: `flutter clean && flutter pub get`

### "Pod install failed" (iOS)
- Run `cd ios && pod install`
- Update CocoaPods: `sudo gem install cocoapods`

### Database not initializing
- Delete and reinstall the app
- Check Hive initialization in `main.dart`

## 📄 License

This project is created for educational purposes. Feel free to use and modify as needed.

## 🤝 Contributing

Contributions welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests

## 📞 Support

For issues or questions:
- Check Flutter documentation: https://flutter.dev/docs
- Hive documentation: https://docs.hivedb.dev/

---

**Built with ❤️ using Flutter**
