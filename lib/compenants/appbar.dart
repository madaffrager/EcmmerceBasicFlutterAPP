import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/counter/cart.counter.dart';
import 'package:shopjdidfirebase/user/cart.dart';
import 'package:shopjdidfirebase/user/login.dart';
import 'package:shopjdidfirebase/user/user.dart';

import '../const.dart';

class MyAppbar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MyAppbarState createState() => _MyAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _MyAppbarState extends State<MyAppbar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person, color: kPrimaryColor),
          onPressed: () {
            if (AuthProvider.preferences.getString(AuthProvider.id) != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }
          },
        ),
        title: Image.asset(
          'images/logo.png',
          fit: BoxFit.fill,
          height: 70,
          alignment: FractionalOffset.centerRight,
        ),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: kPrimaryColor),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
              ),
              Positioned(
                  child: Stack(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 3.0,
                    bottom: 4.0,
                    left: 6.0,
                    child: Consumer<CartItemCounter>(
                        builder: (context, counter, _) {
                      return Text(
                          (AuthProvider.preferences
                                      .getStringList(
                                          AuthProvider.collectionCartlist)
                                      .length -
                                  1)
                              .toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.2,
                              fontWeight: FontWeight.w500));
                    }),
                  )
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
