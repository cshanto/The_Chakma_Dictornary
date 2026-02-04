# Data Management Guide

This guide explains how to manage dictionary entries in your Flutter dictionary app as an administrator.

## Overview

The dictionary app uses **Hive**, a NoSQL database that stores data locally on the user's device. As the app owner, you have two ways to manage dictionary entries:

1. **Backend Script** - Add entries programmatically via command line
2. **Direct Database Access** - Manually edit the Hive database files

## Method 1: Backend Script (Recommended)

### Quick Start

Add a new dictionary entry using the provided Dart script:

```bash
cd dictionary_app
dart scripts/add_dictionary_entry.dart \
  --word "Algorithm" \
  --definition "A step-by-step procedure for solving a problem" \
  --example "The sorting algorithm efficiently organized the data" \
  --tags "programming,computer science"
```

### Command Arguments

| Argument | Required | Description | Example |
|----------|----------|-------------|---------|
| `--word` | ✅ Yes | The word to add | `"Algorithm"` |
| `--definition` | ✅ Yes | Definition of the word | `"A step-by-step procedure..."` |
| `--example` | ❌ No | Example sentence | `"The algorithm sorted..."` |
| `--tags` | ❌ No | Comma-separated tags | `"programming,tech"` |

### Examples

**Simple entry (minimal):**
```bash
dart scripts/add_dictionary_entry.dart \
  --word "Cache" \
  --definition "A hardware or software component that stores data for faster future access"
```

**Complete entry (with all fields):**
```bash
dart scripts/add_dictionary_entry.dart \
  --word "Encryption" \
  --definition "The process of encoding information to prevent unauthorized access" \
  --example "End-to-end encryption protects user messages" \
  --tags "security,cryptography"
```

### Bulk Import from CSV

The easiest way to add many words at once is to use the CSV import script.

1. **Prepare your CSV file:**
   Create a CSV file (e.g., `entries.csv`) with the following headers:
   `word,definition,example,chakma1,chakma1Example,chakma2,chakma2Example`

   See [sample_data.csv](file:///c:/Users/cshan/.gemini/antigravity/playground/neon-magnetar/dictionary_app/sample_data.csv) for a template.

2. **Run the import script:**
   ```bash
   dart scripts/import_from_csv.dart path/to/your/entries.csv
   ```

   **Example:**
   ```bash
   dart scripts/import_from_csv.dart sample_data.csv
   ```

The script will automatically handle quotes, multiple lines, and skip duplicate words already in the database.

## Method 2: Direct Database Access

### Database Location

The Hive database is stored in different locations depending on the platform:

#### Windows
```
C:\Users\<YourUsername>\.dictionary_app\hive_data\
```

#### macOS/Linux
```
~/.dictionary_app/hive_data/
```

#### Web (Browser)
IndexedDB in the browser's application storage

#### Mobile
- **Android**: `/data/data/com.example.dictionary_app/`
- **iOS**: App's Documents directory

### Database Files

Hive creates multiple files:
- `dictionaryBox.hive` - Main database file
- `dictionaryBox.lock` - Lock file (don't edit)

> [!CAUTION]
> Direct manipulation of Hive files can corrupt the database. Always backup before editing manually.

## Backup & Restore

### Backup

**Windows:**
```powershell
Copy-Item -Recurse C:\Users\<YourUsername>\.dictionary_app\hive_data\ C:\Backups\dictionary_backup\
```

**macOS/Linux:**
```bash
cp -r ~/.dictionary_app/hive_data/ ~/backups/dictionary_backup/
```

### Restore

Simply copy the backed-up `hive_data` folder back to the original location.

## Pre-populating Data for Users

To ship the app with pre-loaded dictionary entries:

1. **During Development:**
   - The app automatically adds sample data on first launch (see `database_service.dart`)
   - Modify the `_addSampleData()` method to include your desired entries

2. **For Production:**
   - Run your backend script to populate the database
   - Copy the generated `hive_data` folder to your project
   - Include it in the app bundle (advanced - requires custom asset loading)

## Viewing Current Entries

To see all current entries in the database:

1. Start the Flutter app
2. All entries will be displayed in the main screen
3. Use the search feature to filter entries

Or create a simple script to list all entries:

```dart
// scripts/list_entries.dart
import 'package:hive/hive.dart';
import '../lib/models/dictionary_entry.dart';

void main() async {
  Hive.init('path/to/hive_data');
  Hive.registerAdapter(DictionaryEntryAdapter());
  final box = await Hive.openBox<DictionaryEntry>('dictionaryBox');
  
  print('Total entries: ${box.length}\n');
  
  for (var i = 0; i < box.length; i++) {
    final entry = box.getAt(i)!;
    print('${i + 1}. ${entry.word}: ${entry.definition}');
  }
  
  await box.close();
}
```

## Troubleshooting

### Script fails to run

**Error:** "Could not find package..."

**Solution:** Make sure you're in the `dictionary_app` directory and have run `flutter pub get`

```bash
cd dictionary_app
flutter pub get
dart scripts/add_dictionary_entry.dart --word "Test" --definition "Test entry"
```

### Database not found

**Error:** "Failed to open box"

**Solution:** The database path might be different. Check the script output for the actual path being used.

### Changes not appearing in app

**Solution:** After adding entries via the backend script, you must restart the Flutter app. Hot reload won't work for database changes.

```bash
# Stop the running app (Ctrl+C in terminal or 'q' in Flutter console)
# Then restart
flutter run -d chrome
```

## Best Practices

1. ✅ **Always test entries** - Add a test entry first before bulk importing
2. ✅ **Backup regularly** - Keep backups before making significant changes
3. ✅ **Use consistent formatting** - Follow the same style for all definitions
4. ✅ **Validate data** - Ensure words and definitions don't have typos
5. ✅ **Tag appropriately** - Use tags to help users find related words

## Need Help?

If you encounter issues with data management, check:
- Flutter console output for error messages
- Hive database file permissions
- Correct path to the dictionary_app directory

For further assistance, refer to the [Hive documentation](https://docs.hivedb.dev/).
