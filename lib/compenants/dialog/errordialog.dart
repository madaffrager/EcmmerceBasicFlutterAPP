import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ErrorAlertDialog extends StatelessWidget {
  final String message;
  Color color = Colors.red;
  ErrorAlertDialog({this.color, this.message, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: color,
          child: Text("OK"),
        ),
      ],
    );
  }
}
