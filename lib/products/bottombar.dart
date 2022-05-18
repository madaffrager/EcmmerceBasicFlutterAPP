import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/products/search.dart';
import 'package:shopjdidfirebase/user/favorites.dart';
import 'package:shopjdidfirebase/user/login.dart';
import 'package:shopjdidfirebase/user/user.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 60.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.white),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Products()));
                            },
                            child: Column(children: [
                              Icon(Icons.home_outlined, color: kPrimaryColor),
                              Text(
                                "Acceuil",
                                style: TextStyle(color: Colors.pink),
                              )
                            ]),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchProduct()));
                              },
                              child: Column(
                                children: [
                                  Icon(Icons.search_outlined,
                                      color: kPrimaryColor),
                                  Text(
                                    "Catégories",
                                    style: TextStyle(color: Colors.pink),
                                  )
                                ],
                              ))
                        ],
                      )),
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Favorites()));
                            },
                            child: Column(children: [
                              Icon(Icons.favorite_border_outlined,
                                  color: kPrimaryColor),
                              Text(
                                "Favoris",
                                style: TextStyle(color: Colors.pink),
                              )
                            ]),
                          ),
                          InkWell(
                            onTap: () {
                              if (AuthProvider.id != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              }
                            },
                            child: Column(
                              children: [
                                Icon(Icons.person_outline_rounded,
                                    color: kPrimaryColor),
                                Text(
                                  "Compte",
                                  style: TextStyle(color: Colors.pink),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ])));
  }
}
