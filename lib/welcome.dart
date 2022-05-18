import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/splashPage.dart';
import 'package:shopjdidfirebase/user/SignUp/signup.dart';

class Welcome extends StatefulWidget {
  @override
  _Welcome createState() => _Welcome();
}

class _Welcome extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displaySplash();
  }

  void displaySplash() {
    Timer(Duration(seconds: 5), () async {
      if (await AuthProvider.auth.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Products()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SplashPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "images/top.png",
                width: size.width * 0.3,
              )),
          Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                "images/bot.png",
                width: size.width * 0.2,
              )),
          Center(
              child: Image.asset(
            "images/logo.png",
            height: size.height * 0.3,
            width: size.width * 0.3,
          ))
        ],
      ),
    ));
  }
}
