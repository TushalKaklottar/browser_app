import 'dart:async';
import 'package:browser_app/screen/Home_page.dart';
import 'package:flutter/material.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
    ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => Home_Page())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/browser.png",
          height: 150,
        ),
      ),
    );
  }
}
