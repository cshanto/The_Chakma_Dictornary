// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:dictionary_app/main.dart';
import 'package:dictionary_app/providers/theme_provider.dart';
import 'package:dictionary_app/widgets/dictionary_card.dart';
import 'package:dictionary_app/models/dictionary_entry.dart';

void main() {
  testWidgets('DictionaryCard should show English and Chakma 1 but HIDE Chakma 2', (WidgetTester tester) async {
    final entry = DictionaryEntry(
      word: 'TestWord',
      definition: 'Test Definition',
      example: 'Test Example',
      chakma1: 'C1 Meaning',
      chakma2: 'C2 Meaning', // This should be hidden in UI
    );

    // Wrap in ThemeProvider and MaterialApp to provide necessary context
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MaterialApp(
          home: Scaffold(
            body: DictionaryCard(entry: entry, index: 0),
          ),
        ),
      ),
    );

    // Verify word title is shown
    expect(find.text('TestWord'), findsOneWidget);

    // ExpansionTile titles should be visible
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Chakma 1'), findsOneWidget);

    // Initial check: content should be offstage or not visible
    // Depending on ExpansionTile implementation, it might be in the tree but not visible.
    
    // Expand English section
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Test Definition'), findsOneWidget);

    // Expand Chakma 1 section
    await tester.tap(find.text('Chakma 1'));
    await tester.pumpAndSettle();
    expect(find.text('C1 Meaning'), findsOneWidget);
    
    // VERIFY CHAKMA 2 IS HIDDEN
    expect(find.text('Chakma 2'), findsNothing);
    expect(find.text('C2 Meaning'), findsNothing);
  });
}



