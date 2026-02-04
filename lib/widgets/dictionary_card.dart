import 'package:flutter/material.dart';
import '../models/dictionary_entry.dart';

class DictionaryCard extends StatelessWidget {
  final DictionaryEntry entry;
  final int index;

  const DictionaryCard({
    Key? key,
    required this.entry,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. WORD Title
            Text(
              entry.word,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 16),

            // 2. English Section
            _buildLanguageSection(
              context,
              title: 'English',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.definition,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (entry.example.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'eg: ${entry.example}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                    ),
                  ],
                ],
              ),
            ),

            // 3. Chakma 1 Section
            if (entry.chakma1.isNotEmpty)
              _buildLanguageSection(
                context,
                title: 'Chakma 1',
                content: _buildSimpleMeaning(
                  context,
                  entry.chakma1,
                  example: entry.chakma1Example ?? '',
                ),
              ),

            // 4. Chakma 2 Section
            if (entry.chakma2.isNotEmpty)
              _buildLanguageSection(
                context,
                title: 'Chakma 2',
                content: _buildSimpleMeaning(
                  context,
                  entry.chakma2,
                  example: entry.chakma2Example ?? '',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(
    BuildContext context, {
    required String title,
    required Widget content,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [content],
      ),
    );
  }

  Widget _buildSimpleMeaning(
    BuildContext context,
    String meaning, {
    String example = '',
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meaning,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (example.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'eg: $example',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
            ),
          ],
        ],
      ),
    );
  }




}
