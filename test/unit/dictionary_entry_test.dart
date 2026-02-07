import 'package:flutter_test/flutter_test.dart';
import 'package:dictionary_app/models/dictionary_entry.dart';

void main() {
  group('DictionaryEntry Model Tests', () {
    test('matchesQuery should return true for matching word', () {
      final entry = DictionaryEntry(
        word: 'Apple',
        definition: 'A round fruit',
        example: 'I ate an apple',
      );

      expect(entry.matchesQuery('apple'), isTrue);
      expect(entry.matchesQuery('APP'), isTrue);
      expect(entry.matchesQuery('fruit'), isTrue);
      expect(entry.matchesQuery('orange'), isFalse);
    });

    test('toJson and fromJson should maintain data integrity', () {
      final entry = DictionaryEntry(
        word: 'Chakma',
        definition: 'An ethnic group',
        example: 'Chakma people have a unique culture',
        chakma1: 'চঙমা',
        chakma2: '𑄌𑄇𑄴𑄟𑄧',
        chakma1Example: 'Example 1',
        chakma2Example: 'Example 2',
      );

      final json = entry.toJson();
      final decodedEntry = DictionaryEntry.fromJson(json);

      expect(decodedEntry.word, entry.word);
      expect(decodedEntry.definition, entry.definition);
      expect(decodedEntry.example, entry.example);
      expect(decodedEntry.chakma1, entry.chakma1);
      expect(decodedEntry.chakma2, entry.chakma2);
      expect(decodedEntry.chakma1Example, entry.chakma1Example);
      expect(decodedEntry.chakma2Example, entry.chakma2Example);
    });
  });
}
