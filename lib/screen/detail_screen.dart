import 'package:flutter/material.dart';
import 'package:mygallery/module/classes.dart' as im;
import 'package:provider/provider.dart';

class detailScreen extends StatelessWidget {
  const detailScreen({super.key});
  static const routeName = 'detailScreen';

  @override
  Widget build(BuildContext context) {
    final imageId = ModalRoute.of(context)!.settings.arguments as String;
    final image =
        Provider.of<im.ImageFile>(context, listen: false).findImage(imageId);
    return Scaffold(
      appBar: AppBar(title: Text(image.title)),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: 400,
            width: double.infinity,
            child: Image.file(
              image.image,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            image.title,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            image.story,
            style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
