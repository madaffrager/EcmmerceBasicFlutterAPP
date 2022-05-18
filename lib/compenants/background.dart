import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "images/w3.jpeg",
                width: size.width,
              )),
          Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                "images/bot.png",
                width: size.width * 0.2,
              )),
          child,
        ],
      ),
    );
  }
}
