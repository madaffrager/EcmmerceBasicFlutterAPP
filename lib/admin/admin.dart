import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/admin/adminbody.dart';
import 'package:shopjdidfirebase/user/login.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("",
                style: TextStyle(
                  color: Colors.black,
                )),
            Text(
              "Administration",
              style: TextStyle(color: Colors.pink),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(
                Icons.person_outline,
                color: Colors.pink,
                size: 30,
              )),
        ],
      ),
      body: Body(),
    );
  }
}
