import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopjdidfirebase/compenants/already_have_account.dart';
import 'package:shopjdidfirebase/compenants/dialog/errordialog.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/compenants/rounded_input_field.dart';
import 'package:shopjdidfirebase/compenants/rounded_password_field.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/user/SignUp/orDivider.dart';
import 'package:shopjdidfirebase/user/SignUp/social_icon.dart';
import 'package:shopjdidfirebase/user/login.dart';
import 'backgrounds.dart';

class Body extends StatefulWidget {
  @required
  final Widget child;

  const Body({Key key, this.child}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email, _password, _nom, _confpassword, optionvalue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            "Inscription",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 10,
          ),
          RoundedInputField(
            text: "Nom Complet",
            onchanged: (value) {
              setState(() {
                this._nom = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sexe: ",
                style: TextStyle(color: Colors.pink, fontSize: 17),
              ),
              SizedBox(
                width: size.width * 0.3,
              ),
              DropdownButton<String>(
                value: optionvalue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.pink),
                underline: Container(
                  height: 2,
                  color: Colors.pink,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    optionvalue = newValue;
                  });
                },
                items: <String>['Homme', 'Femme']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          RoundedInputField(
            text: "Email",
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
          RoundedPasswordField(
            onchanged: (value) {
              setState(() {
                this._confpassword = value;
              });
            },
          ),
          RoundedButton(
            text: "Inscription",
            press: () {
              if (_nom.isNotEmpty &&
                  _email.isNotEmpty &&
                  _email.contains("@") &&
                  _password == _confpassword) {
                setState(() {
                  signUp();
                });
              } else {
                showDialog(
                    context: context,
                    builder: (c) {
                      return ErrorAlertDialog(
                        message: "Champs invalides, Veuillez réssayer",
                      );
                    });
              }
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          OrDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialIcon(
                iconsrc: "images/icons/facebook.svg",
                press: () {},
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              SocialIcon(
                iconsrc: "images/icons/google-plus.svg",
                press: () {
                  //   signupwithgoogle();
                },
              ),
            ],
          )
        ],
      ),
    ));
  }

  void signUp() async {
    User user;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((auth) {
        user = auth.user;
      });
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: 'Erreur d\'inscription, veuillez réssayer',
            );
          });
    }
    if (user != null) {
      saveUserInfoToFireStore(user).then((value) {
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Products()));
      });
    }
  }

  Future saveUserInfoToFireStore(User user) async {
    FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "id": user.uid,
      "name": _nom,
      "email": _email,
      "gender": optionvalue,
      AuthProvider.collectionCartlist: ["garbageValue"],
    });
    await AuthProvider.preferences.setString("id", user.uid);
    await AuthProvider.preferences.setString(AuthProvider.name, _nom);
    await AuthProvider.preferences.setString(AuthProvider.gender, optionvalue);
    await AuthProvider.preferences.setString(AuthProvider.email, _email);
    await AuthProvider.preferences
        .setStringList(AuthProvider.collectionCartlist, ['garbageValue']);
  }

  Future signupwithgoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorAlertDialog(
                  message: "un autre compte existe avec ces coordonnées",
                );
              });
        } else if (e.code == 'invalid-credential') {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorAlertDialog(
                  message: "Coordonnées invalides",
                );
              });
        }
      } catch (e) {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorAlertDialog(
                message: "Erreur d'authentification",
              );
            });
      }
    }
    _nom = user.displayName;
    _email = user.email;
    optionvalue = "Homme";
    saveUserInfoToFireStore(user);
    Fluttertoast.showToast(msg: "Félicitations pour votre inscription!");
  }
}
