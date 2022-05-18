import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/appbar.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      body: Column(
        children: [
          Center(
            child: Text("Vous n'avez pas de favoris !"),
          ),
          SizedBox(
            height: 50,
          ),
          RoundedButton(
            text: "Retournez au shop",
            press: () {
              Navigator.pushNamed(context, "/prods");
            },
          )
        ],
      ),
    );
  }
}
