import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../const.dart';

class SocialIcon extends StatelessWidget {
  final String iconsrc;
  final Function press;
  const SocialIcon({
    this.iconsrc,
    this.press,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, color: kPrimaryColor)),
        child: SvgPicture.asset(
          iconsrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
