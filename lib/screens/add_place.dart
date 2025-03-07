import 'dart:io';

import 'package:facorite_places/providers/user_places.dart';
import 'package:facorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();

  File? _selectedImage;

  void _savePlaces() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlaces(enteredTitle, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a new place")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            SizedBox(height: 10),

            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlaces,
              icon: Icon(Icons.add),
              label: Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}
