import 'package:flutter/material.dart';
import 'package:mygallery/screen/image_Input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:mygallery/module/classes.dart';

class MyInputScreen extends StatefulWidget {
  const MyInputScreen({super.key});
  static const routeName = 'MyInputScreen';
  @override
  State<MyInputScreen> createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();
  File? savedImage;

  void savedImages(File image) {
    savedImage = image;
  }

  void onSave() {
    if (_titleController.text.isEmpty ||
        _storyController.text.isEmpty ||
        savedImage == null) {
      return;
    } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
          _titleController.text, _storyController.text, savedImage!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
        actions: [
          IconButton(onPressed: onSave, icon: const Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _storyController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(
                height: 30,
              ),
              ImageInput(savedImages),
            ],
          ),
        ),
      ),
    );
  }
}
