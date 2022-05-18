import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/already_have_account.dart';
import 'package:shopjdidfirebase/compenants/dialog/errordialog.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/compenants/rounded_input_field.dart';
import 'package:shopjdidfirebase/compenants/rounded_password_field.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/user/SignUp/signup.dart';
import 'backgroundlog.dart';

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
            SizedBox(
              height: 20,
            ),
            Text(
              "Connexion",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              text: "Votre Email",
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
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (_email.isNotEmpty && _email.contains("@") && _password.length > 7) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        User user = result.user;
        if (user != null) {
          AuthProvider.preferences.setString("id", user.uid);
          readData(user);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Products()));
        }
      } catch (e) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
              ErrorAlertDialog(
                message: "Echec de connexion, vérifiez vos  informations!",
              );
            });
      }
    }
  }
}

Future readData(User user) async {
  FirebaseFirestore.instance
      .collection("users")
      .doc(user.uid)
      .get()
      .then((dataSnapshot) async {
    await AuthProvider.preferences.setString(
        AuthProvider.id, dataSnapshot.get(AuthProvider.id).toString());
    await AuthProvider.preferences.setString(
        AuthProvider.name, dataSnapshot.get(AuthProvider.name).toString());
    await AuthProvider.preferences.setString(
        AuthProvider.email, dataSnapshot.get(AuthProvider.email).toString());
    await AuthProvider.preferences.setString(
        AuthProvider.gender, dataSnapshot.get(AuthProvider.gender).toString());
    await AuthProvider.preferences.setStringList(
        AuthProvider.collectionCartlist,
        dataSnapshot.get(AuthProvider.collectionCartlist).cast<String>());
  });
}
