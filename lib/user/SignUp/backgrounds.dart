import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

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
            child: Image.asset(
              "images/tops.png",
              width: size.width * 0.35,
            ),
            top: 0,
            left: 0,
          ),
          Positioned(
            child: Image.asset(
              "images/bot.png",
              width: size.width * 0.25,
            ),
            bottom: 0,
            left: 0,
          ),
          child,
        ],
      ),
    );
  }
}
