import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/admin/uploadItems.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/config/config.dart';

class DashBoard extends StatelessWidget {
  final String name;

  const DashBoard({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              "Admin",
              style: TextStyle(color: Colors.pink),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: size.height * 0.05,
                left: 0,
                child: Image.asset(
                  "images/user.png",
                  width: size.width * 1,
                )),
            Positioned(
              top: size.height * 0.04,
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: Image.asset("images/b0.png")),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bonjour Abdenour Teggour",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: FlatButton(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UploadItems()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "  Ajouter des produits",
                                    style: TextStyle(
                                        color: Colors.pink, fontSize: 14),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                    text: "Se déconnecter",
                    press: () {
                      AuthProvider.auth.signOut().then((c) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/login");
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
