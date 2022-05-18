import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/user/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String text;
  final IconData icon;
  final ValueChanged<String> onchanged;

  const RoundedInputField({
    this.text,
    this.onchanged,
    this.icon = Icons.person,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onchanged,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: text,
            border: InputBorder.none),
      ),
    );
  }
}
