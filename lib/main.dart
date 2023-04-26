import 'package:flutter/material.dart';
import 'package:gallery_app/views/screens/homepage.dart';
import 'package:gallery_app/views/screens/image_view.dart';
import 'package:gallery_app/views/screens/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "splash_screen",
    routes: {
      "/":(context) => HomePage(),
      "image_view":(context) => ImageViewPage(),
      "splash_screen":(context) => SplashScreenPage(),
    },
  ));
}
