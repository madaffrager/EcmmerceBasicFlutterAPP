import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/admin/dashboard.dart';
import 'package:shopjdidfirebase/compenants/dialog/errordialog.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/compenants/rounded_input_field.dart';
import 'package:shopjdidfirebase/compenants/rounded_password_field.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/user/backgroundlog.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Products()));
              },
              child: Text(
                "Retour à la page d'acceuil >>",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              "images/logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              text: "Admin ID",
              onchanged: (value) {
                setState(() {
                  this._email = value;
                });
              },
            ),
            RoundedPasswordField(
              onchanged: (value) {
                setState(() {
                  this._password = value;
                });
              },
            ),
            RoundedButton(
              text: "Connexion",
              press: signIn,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    FirebaseFirestore.instance.collection("admins").get().then((snapshotData) {
      snapshotData.docs.forEach((element) {
        if (element.get("password") != _email) {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorAlertDialog(
                  message: "ID invalide",
                );
              });
        }
        if (element.get("password") != _password) {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorAlertDialog(
                  message: "mot de passe invalide",
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorAlertDialog(
                  color: Colors.green,
                  message: "Bonjour ",
                );
              });

          setState(() {
            _email = "";
            _password = "";
          });

          String name = element.get("name");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashBoard(name: name)));
        }
      });
    });
  }
}
