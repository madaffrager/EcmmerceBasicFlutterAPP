import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/user/login.dart';

import 'body.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(" ",
                style: TextStyle(
                  color: Colors.black,
                )),
            Image.asset(
              'images/logo.png',
              fit: BoxFit.fill,
              height: 80,
              alignment: FractionalOffset.centerRight,
            ),
          ],
        ),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                "Se connecter",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: Body(),
    );
  }
}
