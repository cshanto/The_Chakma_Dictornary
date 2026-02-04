import 'dart:io';
import 'package:hive/hive.dart';
import '../lib/models/dictionary_entry.dart';

/// Backend script to add dictionary entries to the Hive database
/// 
/// Usage:
///   dart scripts/add_dictionary_entry.dart --word "Algorithm" --definition "A step-by-step procedure" --example "The algorithm sorted the data" --tags "programming,computer science"
/// 
/// Arguments:
///   --word: The word to add (required)
///   --definition: The definition of the word (required)
///   --example: An example sentence (optional)
///   --chakma1: First Chakma translation (optional)
///   --chakma1Example: Example for First Chakma (optional)
///   --chakma2: Second Chakma translation (optional)
///   --chakma2Example: Example for Second Chakma (optional)
///   --tags: Comma-separated tags (optional)

void main(List<String> arguments) async {
  // Parse arguments
  final args = _parseArguments(arguments);
  
  if (args == null || !args.containsKey('word') || !args.containsKey('definition')) {
    print('❌ Error: Missing required arguments');
    print('');
    print('Usage:');
    print('  dart scripts/add_dictionary_entry.dart --word "Word" --definition "Definition" [--example "Example"] [--chakma1 "C1"] [--chakma1Example "C1E"] [--chakma2 "C2"] [--chakma2Example "C2E"] [--tags "tag1,tag2"]');
    print('');
    print('Example:');
    print('  dart scripts/add_dictionary_entry.dart --word "Algorithm" --definition "A step-by-step procedure for solving a problem" --chakma1 "Translation 1" --tags "programming"');
    exit(1);
  }

  try {
    // Initialize Hive
    print('📂 Initializing database...');
    
    // Set the path for the Hive database
    // On Windows, this will be in the user's AppData\Roaming directory
    final homeDir = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
    final hivePath = '$homeDir/.dictionary_app/hive_data';
    
    // Create directory if it doesn't exist
    final directory = Directory(hivePath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('✅ Created database directory: $hivePath');
    }
    
    Hive.init(hivePath);
    Hive.registerAdapter(DictionaryEntryAdapter());
    
    // Open the box
    final box = await Hive.openBox<DictionaryEntry>('dictionaryBox');
    print('✅ Database opened successfully');
    
    // Create the entry
    final entry = DictionaryEntry(
      word: args['word']!,
      definition: args['definition']!,
      example: args['example'] ?? '',
      chakma1: args['chakma1'] ?? '',
      chakma1Example: args['chakma1Example'] ?? '',
      chakma2: args['chakma2'] ?? '',
      chakma2Example: args['chakma2Example'] ?? '',

    );
    
    // Add to database
    await box.add(entry);
    print('');
    print('✅ Successfully added entry:');
    print('   Word: ${entry.word}');
    print('   Definition: ${entry.definition}');
    if (entry.example.isNotEmpty) {
      print('   Example: ${entry.example}');
    }
    if (entry.chakma1.isNotEmpty) {
      print('   Chakma 1: ${entry.chakma1}');
    }
    if (entry.chakma1Example != null && entry.chakma1Example!.isNotEmpty) {
      print('   Chakma 1 Example: ${entry.chakma1Example}');
    }
    if (entry.chakma2.isNotEmpty) {
      print('   Chakma 2: ${entry.chakma2}');
    }
    if (entry.chakma2Example != null && entry.chakma2Example!.isNotEmpty) {
      print('   Chakma 2 Example: ${entry.chakma2Example}');
    }

    print('');
    print('📊 Total entries in database: ${box.length}');
    
    // Close the box
    await box.close();
    await Hive.close();
    
    print('');
    print('✅ Done! Restart the Flutter app to see the new entry.');
    
  } catch (e) {
    print('❌ Error: $e');
    exit(1);
  }
}

Map<String, String>? _parseArguments(List<String> args) {
  final result = <String, String>{};
  
  for (int i = 0; i < args.length; i++) {
    if (args[i].startsWith('--')) {
      final key = args[i].substring(2);
      if (i + 1 < args.length && !args[i + 1].startsWith('--')) {
        result[key] = args[i + 1];
        i++; // Skip the next argument since we've already consumed it
      }
    }
  }
  
  return result.isEmpty ? null : result;
}
