import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../models/globals.dart';
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 12),
      () => Navigator.pushReplacementNamed(context, "/"),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
         
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
             height: MediaQuery.of(context).size.height*0.5,
             width: MediaQuery.of(context).size.width,
             child: Image.network("https://img.freepik.com/premium-vector/meditation-concept_23-2148533711.jpg"),
            ),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            child: Image.asset("assets/images/explore.jpeg")),
            LoadingAnimationWidget.staggeredDotsWave(color: Colors.grey, size: 50)
          ],
        ),
      ),
    );
  }
}
