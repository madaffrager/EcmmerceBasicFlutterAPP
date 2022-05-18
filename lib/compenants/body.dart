import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/user/SignUp/signup.dart';
import 'package:shopjdidfirebase/user/login.dart';

import 'background.dart';
import 'rounded.button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.12,
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            SizedBox(
              height: size.height * 0.0,
            ),
            RoundedButton(
              text: "Connexion",
              color: kPrimaryColor,
              textcol: Colors.white,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            RoundedButton(
              text: "Inscription",
              color: kPrimaryLightColor,
              textcol: Colors.black,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
