# Testing Guide - Dictionary App

## 🧪 Testing Without Running the App

### Code Quality Checks

You can verify the code quality even without Flutter:

```powershell
# Check for syntax errors (after installing Flutter)
flutter analyze

# Format code
flutter format lib/

# Run static analysis
dart analyze
```

---

## ✅ Manual Testing Checklist (Once App is Running)

### 1. **Theme Functionality**
- [ ] Open app (should show light theme by default)
- [ ] Tap sun/moon icon in app bar
- [ ] Verify dark theme applies
- [ ] Close and reopen app
- [ ] Verify theme preference persists

### 2. **Search Functionality**
- [ ] Type "api" in search bar
- [ ] Verify only matching words appear
- [ ] Clear search with X button
- [ ] Verify all words return

### 3. **Add Word**
- [ ] Tap + floating button
- [ ] Enter word: "Test"
- [ ] Enter definition: "A test definition"
- [ ] Enter example: "This is a test"
- [ ] Tap save
- [ ] Verify word appears in list

### 4. **Edit Word**
- [ ] Tap edit icon on any word card
- [ ] Modify the definition
- [ ] Save changes
- [ ] Verify changes persist

### 5. **Delete Word**
- [ ] Tap delete icon on a word
- [ ] Confirm deletion in dialog
- [ ] Verify word is removed

### 6. **Offline Functionality**
- [ ] Turn on airplane mode
- [ ] Open app
- [ ] Verify all features work
- [ ] Add/edit/delete words
- [ ] Verify changes persist

### 7. **View Word Details**
- [ ] Tap on any word card
- [ ] Verify full details dialog appears
- [ ] Close dialog

---

## 🚀 Quick Start Testing Commands

### Install and Run (Complete Flow)

```powershell
# 1. Navigate to project
cd c:\Users\cshan\.gemini\antigravity\playground\neon-magnetar\dictionary_app

# 2. Get dependencies
flutter pub get

# 3. Run on Chrome (fastest)
flutter run -d chrome

# OR run on Android
flutter run

# 4. Test hot reload
# Make a small change to the code
# Press 'r' in terminal to hot reload
# Press 'R' to hot restart
# Press 'q' to quit
```

---

## 📱 Platform-Specific Testing

### Test on Android

```powershell
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run in release mode (optimized)
flutter run --release
```

### Test on iOS (macOS only)

```bash
open -a Simulator
flutter run
```

---

## 🐛 Debugging Tips

### Check for Errors
```powershell
# View detailed logs
flutter logs

# Run with verbose output
flutter run -v
```

### Common Issues

**Issue**: Hive database error
```powershell
# Solution: Clear app data
flutter clean
flutter pub get
# Uninstall and reinstall app
```

**Issue**: Hot reload not working
```powershell
# Press 'R' for hot restart instead of 'r'
```

---

## ⚡ Performance Testing

### Check App Size
```powershell
flutter build apk --analyze-size
```

### Check Performance
```powershell
# Run with performance overlay
flutter run --enable-software-rendering
```

---

## 📊 Automated Tests (Optional)

If you want to write automated tests, create `test/widget_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:dictionary_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Verify search bar exists
    expect(find.text('Search words...'), findsOneWidget);
    
    // Verify FAB exists
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
```

Run tests:
```powershell
flutter test
```

---

## 🎯 What to Test

| Feature | Expected Behavior |
|---------|------------------|
| **Initial Load** | 20 sample words visible |
| **Search** | Real-time filtering |
| **Theme Toggle** | Switches between light/dark |
| **Theme Persistence** | Saved after app restart |
| **Add Word** | Appears in list immediately |
| **Edit Word** | Changes reflect immediately |
| **Delete Word** | Removes from list |
| **Offline Mode** | All features work |
| **Form Validation** | Empty fields show error |

---

## 💡 Quick Test Without Installation

Want to see the code structure and verify it's correct?

```powershell
# Count lines of code
Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse | Get-Content | Measure-Object -Line

# Check file structure
tree /F lib
```
