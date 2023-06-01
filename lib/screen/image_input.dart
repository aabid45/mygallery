import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  const ImageInput(this.imagesaveat, {super.key});
  final Function imagesaveat;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });
    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveimagepath = await _imageFile?.copy('${apDir.path}/$fileName');

    widget.imagesaveat(saveimagepath);
  }

  Future<void> _galleryPicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });
    final apDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final saveimagepath = await _imageFile?.copy('${apDir.path}/$fileName');

    widget.imagesaveat(saveimagepath);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.yellowAccent)),
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                )
              : const Center(child: Text('No Image Yet, Add One')),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _galleryPicture,
              icon: const Icon(Icons.image),
              label: const Text('Add Your Image'),
            ),
            TextButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
            ),
          ],
        )
      ],
    );
  }
}
