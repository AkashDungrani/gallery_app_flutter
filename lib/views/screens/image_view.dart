import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gallery_app/models/image_helper.dart';
import 'package:share_plus/share_plus.dart';

import '../../helper/api_helper.dart';
import '../../models/globals.dart';

class ImageViewPage extends StatefulWidget {
  const ImageViewPage({super.key});

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Photos viewimage = ModalRoute.of(context)!.settings.arguments as Photos;
    return Scaffold(
      backgroundColor: (Globals.isdark == true) ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          "GalleryApp",
          style: TextStyle(
            color: (Globals.isdark == true) ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: (Globals.isdark == true) ? Colors.black : Colors.white,
        leading: GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: (Globals.isdark == true) ? Colors.white : Colors.black,
            )),
      ),
      body: Center(
        child: Column(children: [
          Expanded(
            flex: 8,
            child: GestureDetector(
              onDoubleTap: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Hero(
                tag: viewimage.preview,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: height * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          spreadRadius: 25,
                          blurStyle: BlurStyle.outer,
                          color: Colors.grey),
                    ],
                    // color: Colors.amber
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      viewimage.largeimage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
              width: width,
              color: (Globals.isdark == true) ? Colors.black : Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            content: Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text("Download Complete."),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                          ));
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(Icons.download),
                      backgroundColor: Colors.green,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        await Share.share(viewimage.largeimage);
                      },
                      child: Icon(Icons.share),
                      backgroundColor: Colors.orange,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Icon(Icons.delete),
                      backgroundColor: Colors.red,
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
