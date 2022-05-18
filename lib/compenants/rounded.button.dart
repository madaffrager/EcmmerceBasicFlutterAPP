import 'package:flutter/material.dart';

import '../const.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textcol;
  const RoundedButton({
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textcol = Colors.white,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
            color: color,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(color: textcol),
            )),
      ),
    );
  }
}
