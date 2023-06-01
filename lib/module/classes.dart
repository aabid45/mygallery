import 'dart:io';
import 'package:flutter/foundation.dart';
import 'database.dart';

class Image {
  final String id;
  final String title;
  final String story;
  final File image;
  Image(
      {required this.id,
      required this.title,
      required this.story,
      required this.image});
}

class ImageFile with ChangeNotifier {
  List<Image> _items = [];
  List<Image> get items {
    return [..._items];
  }

  Future<void> addImagePlace(String title, String story, File image) async {
    final newImage = Image(
      image: image,
      id: DateTime.now().toString(),
      title: title,
      story: story,
    );
    _items.add(newImage);
    notifyListeners();

    dataSaver.insert('user_image', {
      'id': newImage.id,
      'story': newImage.story,
      'image': newImage.image.path,
      'title': newImage.title,
    });
  }

  Image findImage(String imageId) {
    return _items.firstWhere((image) => image.id == imageId);
  }

  Future<void> fetchImage() async {
    final list = await dataSaver.getData('user_image');
    _items = list
        .map(
          (item) => Image(
            image: File(item['image']),
            id: (item['id']),
            title: (item['title']),
            story: (item['story']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
