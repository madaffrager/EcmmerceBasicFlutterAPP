import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/counter/cart.counter.dart';
import 'package:shopjdidfirebase/counter/change.address.dart';
import 'package:shopjdidfirebase/counter/total.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/products/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopjdidfirebase/user/address.dart';
import 'package:shopjdidfirebase/user/cart.dart';
import 'package:shopjdidfirebase/user/login.dart';
import 'package:shopjdidfirebase/user/orders.dart';
import 'package:shopjdidfirebase/user/user.dart';
import 'package:shopjdidfirebase/welcome.dart';

import 'counter/itemquantity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthProvider.auth = FirebaseAuth.instance;
  AuthProvider.preferences = await SharedPreferences.getInstance();
  AuthProvider.firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => ItemQuantity()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Luna Shop',
        routes: {
          "/home": (context) => ProfilePage(),
          "/search": (context) => SearchProduct(),
          "/adresse": (context) => Address(),
          "/cart": (context) => Cart(),
          "/orders": (context) => MyOrders(),
          "/login": (context) => LoginPage(),
          "/prods": (context) => Products(),
          //"/prods": (context) => Products(),
        },
        theme: ThemeData(
            primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
        home: Welcome(),
      ),
    );
  }
}
