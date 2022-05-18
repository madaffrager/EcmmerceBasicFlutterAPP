import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/user/text_field_container.dart';

import '../const.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onchanged;
  const RoundedPasswordField({
    this.onchanged,
    Key key,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _isHidden,
        onChanged: widget.onchanged,
        decoration: InputDecoration(
            hintText: "Mot de passe",
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _isHidden = !_isHidden;
                });
              },
              child: Icon(
                _isHidden ? Icons.visibility_off : Icons.visibility,
                color: kPrimaryColor,
              ),
            ),
            border: InputBorder.none),
      ),
    );
  }
}
