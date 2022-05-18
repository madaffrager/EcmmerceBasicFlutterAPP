import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    @required this.child,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("images/top.png", width: size.width * 0.35),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("images/botr.png", width: size.width * 0.4),
          ),
          child,
        ],
      ),
    );
  }
}
