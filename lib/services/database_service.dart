import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/dictionary_entry.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static const String _boxName = 'dictionaryBox';
  Box<DictionaryEntry>? _box;

  // Initialize Hive and open box
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DictionaryEntryAdapter());
    _box = await Hive.openBox<DictionaryEntry>(_boxName);
    
    // Always check for new entries in assets on startup
    await _loadDataFromAssets();
  }

  Box<DictionaryEntry> get box {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Database not initialized. Call init() first.');
    }
    return _box!;
  }

  // CRUD Operations
  Future<void> addEntry(DictionaryEntry entry) async {
    await box.add(entry);
  }

  Future<void> updateEntry(int index, DictionaryEntry entry) async {
    await box.putAt(index, entry);
  }

  Future<void> deleteEntry(int index) async {
    await box.deleteAt(index);
  }

  List<DictionaryEntry> getAllEntries() {
    return box.values.toList();
  }

  List<DictionaryEntry> searchEntries(String query) {
    if (query.isEmpty) return getAllEntries();
    
    return box.values
        .where((entry) => entry.matchesQuery(query))
        .toList();
  }

  // Load dictionary data from assets
  Future<void> _loadDataFromAssets() async {
    try {
      final String response = await rootBundle.loadString('assets/data/dictionary.json');
      final List<dynamic> data = json.decode(response);
      
      final List<DictionaryEntry> entries = data
          .map((json) => DictionaryEntry.fromJson(json))
          .toList();

      for (var entry in entries) {
        if (!_box!.values.any((e) => e.word == entry.word)) {
          await addEntry(entry);
        }
      }
      print('✅ Loaded ${entries.length} entries from assets');
    } catch (e) {
      print('❌ Error loading data from assets: $e');
    }
  }

  Future<void> close() async {
    await _box?.close();
  }
}
