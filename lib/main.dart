import 'package:flutter/material.dart';
import 'package:mygallery/screen/my_home_page.dart';
import 'package:mygallery/screen/my_input_page.dart';
import 'package:provider/provider.dart';
import 'package:mygallery/module/classes.dart';
import 'package:mygallery/screen/detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ImageFile(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My Gallery",
        theme: ThemeData.dark(),
        home: const MyHomePage(),
        routes: {
          MyInputScreen.routeName: (cxt) => const MyInputScreen(),
          detailScreen.routeName: (cxt) => const detailScreen(),
        },
      ),
    );
  }
}
