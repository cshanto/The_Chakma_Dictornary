import 'package:flutter/material.dart';
import '../models/dictionary_entry.dart';
import '../services/database_service.dart';

class AddEditScreen extends StatefulWidget {
  final DictionaryEntry? entry;
  final int? index;

  const AddEditScreen({
    Key? key,
    this.entry,
    this.index,
  }) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _wordController;
  late TextEditingController _definitionController;
  late TextEditingController _exampleController;
  final DatabaseService _db = DatabaseService();

  bool get isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController(text: widget.entry?.word ?? '');
    _definitionController = TextEditingController(text: widget.entry?.definition ?? '');
    _exampleController = TextEditingController(text: widget.entry?.example ?? '');
  }

  @override
  void dispose() {
    _wordController.dispose();
    _definitionController.dispose();
    _exampleController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final entry = DictionaryEntry(
        word: _wordController.text.trim(),
        definition: _definitionController.text.trim(),
        example: _exampleController.text.trim(),
      );

      if (isEditing && widget.index != null) {
        await _db.updateEntry(widget.index!, entry);
      } else {
        await _db.addEntry(entry);
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Word' : 'Add New Word'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
            tooltip: 'Save',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Word field
            TextFormField(
              controller: _wordController,
              decoration: const InputDecoration(
                labelText: 'Word',
                hintText: 'Enter the word',
                prefixIcon: Icon(Icons.text_fields),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a word';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Definition field
            TextFormField(
              controller: _definitionController,
              decoration: const InputDecoration(
                labelText: 'Definition',
                hintText: 'Enter the definition',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a definition';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Example field
            TextFormField(
              controller: _exampleController,
              decoration: const InputDecoration(
                labelText: 'Example (Optional)',
                hintText: 'Enter an example sentence',
                prefixIcon: Icon(Icons.format_quote),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Save button
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: Text(isEditing ? 'Update Word' : 'Add Word'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
