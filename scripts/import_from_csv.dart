import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import '../lib/models/dictionary_entry.dart';

/// Backend script to import dictionary entries from a CSV file into the JSON asset.
/// 
/// Usage:
///   dart scripts/import_from_csv.dart path/to/entries.csv
/// 
/// CSV Format (Headers):
///   word,definition,example,chakma1,chakma1Example,chakma2,chakma2Example
void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('❌ Error: Missing CSV file path');
    print('Usage: dart scripts/import_from_csv.dart path/to/entries.csv');
    exit(1);
  }

  final csvFilePath = arguments[0];
  final csvFile = File(csvFilePath);
  final jsonFilePath = 'assets/data/dictionary.json';
  final jsonFile = File(jsonFilePath);

  if (!csvFile.existsSync()) {
    print('❌ Error: CSV file not found: $csvFilePath');
    exit(1);
  }

  try {
    // 1. Load existing entries from JSON
    print('📂 Loading existing data from $jsonFilePath...');
    List<DictionaryEntry> entries = [];
    if (jsonFile.existsSync()) {
      final String jsonString = jsonFile.readAsStringSync();
      final List<dynamic> jsonList = json.decode(jsonString);
      entries = jsonList.map((e) => DictionaryEntry.fromJson(e)).toList();
      print('✅ Loaded ${entries.length} existing entries');
    } else {
      print('ℹ️ JSON file not found, starting fresh');
    }

    // 2. Read and parse CSV
    print('📄 Reading CSV file: $csvFilePath...');
    final input = csvFile.readAsStringSync();
    final fields = const CsvToListConverter(shouldParseNumbers: false).convert(input);

    if (fields.isEmpty) {
      print('❌ Error: CSV file is empty');
      exit(1);
    }

    final headers = fields[0].map((e) => e.toString().toLowerCase().trim()).toList();
    print('📊 Found headers: ${headers.join(', ')}');

    int importedCount = 0;
    int skippedCount = 0;

    // 3. Merge new entries
    for (int i = 1; i < fields.length; i++) {
      final row = fields[i];
      if (row.isEmpty) continue;

      final data = <String, String>{};
      for (int j = 0; j < headers.length; j++) {
        if (j < row.length) {
          data[headers[j]] = row[j].toString().trim();
        }
      }

      final word = data['word'] ?? '';
      final definition = data['definition'] ?? '';

      if (word.isEmpty || definition.isEmpty) {
        print('⚠️ Skipping row ${i + 1}: Missing word or definition');
        skippedCount++;
        continue;
      }

      // Check for duplicates in the existing list
      if (entries.any((e) => e.word.toLowerCase() == word.toLowerCase())) {
        print('ℹ️ Skipping "$word": Already exists in dictionary.json');
        skippedCount++;
        continue;
      }

      final entry = DictionaryEntry(
        word: word,
        definition: definition,
        example: data['example'] ?? '',
        chakma1: data['chakma1'] ?? '',
        chakma1Example: data['chakma1example'] ?? '', // CSV headers are lowercase
        chakma2: data['chakma2'] ?? '',
        chakma2Example: data['chakma2example'] ?? '',
      );

      entries.add(entry);
      importedCount++;
      print('✅ Added: $word');
    }

    // 4. Save back to JSON
    print('\n💾 Saving updated data to $jsonFilePath...');
    const encoder = JsonEncoder.withIndent('  ');
    final String updatedJson = encoder.convert(entries.map((e) => e.toJson()).toList());
    jsonFile.writeAsStringSync(updatedJson);

    print('\n🚀 Process completed!');
    print('📊 Successfully added: $importedCount entries');
    print('📊 Skipped: $skippedCount entries');
    print('📊 Total entries in dictionary.json: ${entries.length}');
    print('\n✅ Done! Now REBUILD your app to include the new data in the bundle.');

  } catch (e) {
    print('❌ Error: $e');
    exit(1);
  }
}
