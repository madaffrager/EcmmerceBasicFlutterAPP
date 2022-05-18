import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/products/bottombar.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/user/address.dart';
import 'package:shopjdidfirebase/user/adressshow.dart';
import 'package:shopjdidfirebase/user/mycards.dart';
import 'package:shopjdidfirebase/user/orders.dart';
import '../const.dart';
import 'cart.dart';

class ProfilePage extends StatelessWidget {
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
              "Compte",
              style: TextStyle(color: Colors.pink),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Products()));
              },
              icon: Icon(
                Icons.home,
                color: Colors.pink,
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
                      child: AuthProvider.preferences
                                  .getString(AuthProvider.gender) ==
                              "Homme"
                          ? Image.asset("images/b0.png")
                          : Image.asset("images/b0.jpg")),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bonjour ${AuthProvider.preferences.getString(AuthProvider.name)}!",
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
                                          builder: (context) => MyOrders()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.shopping_bag_outlined,
                                        color: kPrimaryColor,
                                      ),
                                      Text(
                                        "  Mes commandes",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
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
                                          builder: (context) => Products()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.local_offer_outlined,
                                        color: kPrimaryColor,
                                      ),
                                      Text(
                                        "  Voir les promos",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
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
                                          builder: (context) => AddressShow()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: kPrimaryColor,
                                      ),
                                      Text(
                                        "  Mes adresses",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreditCardsPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.payment_outlined,
                                        color: kPrimaryColor,
                                      ),
                                      Text(
                                        "  Mes cartes",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        )
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyOrders()));
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.shopping_bag),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
    // ignore: dead_code
  }
}
