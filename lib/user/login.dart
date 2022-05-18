import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/admin/admin.dart';

import 'bodylog.dart';

class LoginPage extends StatelessWidget {
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
              "Compte de Client",
              style: TextStyle(color: Colors.pink),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminPage()));
              },
              icon: Icon(
                Icons.lock,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: Body(),
    );
  }
}
