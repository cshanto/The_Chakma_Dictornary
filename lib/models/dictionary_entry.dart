import 'package:hive/hive.dart';

part 'dictionary_entry.g.dart';

@HiveType(typeId: 0)
class DictionaryEntry extends HiveObject {
  @HiveField(0)
  String word;

  @HiveField(1)
  String definition;

  @HiveField(2)
  String example;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  String chakma1;

  @HiveField(5)
  String chakma2;

  @HiveField(6)
  String? chakma1Example;

  @HiveField(7)
  String? chakma2Example;

  DictionaryEntry({
    required this.word,
    required this.definition,
    required this.example,
    this.chakma1 = '',
    this.chakma2 = '',
    this.chakma1Example,
    this.chakma2Example,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // For search functionality
  bool matchesQuery(String query) {
    final lowercaseQuery = query.toLowerCase();
    return word.toLowerCase().contains(lowercaseQuery) ||
        definition.toLowerCase().contains(lowercaseQuery);
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'definition': definition,
      'example': example,
      'chakma1': chakma1,
      'chakma2': chakma2,
      'chakma1Example': chakma1Example,
      'chakma2Example': chakma2Example,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    return DictionaryEntry(
      word: json['word'],
      definition: json['definition'],
      example: json['example'] ?? '',
      chakma1: json['chakma1'] ?? '',
      chakma2: json['chakma2'] ?? '',
      chakma1Example: json['chakma1Example'],
      chakma2Example: json['chakma2Example'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
