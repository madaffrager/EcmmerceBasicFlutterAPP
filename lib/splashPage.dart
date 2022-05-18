import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/body.dart';
import 'package:shopjdidfirebase/user/SignUp/signup.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.pink,
                  size: 30,
                )),
          ],
        ),
        body: Body());
  }
}
