import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mygallery/screen/my_input_page.dart';
import 'package:provider/provider.dart';
import 'package:mygallery/module/classes.dart' as im;
import 'package:mygallery/screen/detail_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.pushNamed(context, MyInputScreen.routeName);
        },
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: const Text('My Gallery'),
      ),
      body: FutureBuilder(
        future: Provider.of<im.ImageFile>(context, listen: false).fetchImage(),
        builder: ((ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<im.ImageFile>(
                child: const Center(child: Text('Start Adding Your Images')),
                builder: (ctx, image, ch) => image.items.length <= 0
                    ? ch!
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GridTile(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, detailScreen.routeName,
                                        arguments: image.items[i].id);
                                  },
                                  child: Image.file(
                                    image.items[i].image,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            footer: GridTileBar(
                              leading: Text(
                                image.items[i].title,
                                style: const TextStyle(
                                    fontSize: 30, fontStyle: FontStyle.italic),
                              ),
                              title: const Text(' '),
                              subtitle: Text(image.items[i].id),
                            ),
                          ),
                        ),
                        itemCount: image.items.length,
                      ),
              )),
      ),
    );
  }
}
