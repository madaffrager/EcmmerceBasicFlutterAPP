import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/counter/cart.counter.dart';
import 'package:shopjdidfirebase/products/productdetail.dart';
import 'package:shopjdidfirebase/user/cart.dart';

class SingleProduct extends StatelessWidget {
  final String categ;
  SingleProduct({this.categ});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .orderBy('name', descending: true)
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  return !dataSnapshot.hasData
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.pink,
                            ),
                          ),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (68 / 100),
                          controller: ScrollController(keepScrollOffset: false),
                          scrollDirection: Axis.vertical,
                          children: [
                            for (int j = 0;
                                j < dataSnapshot.data.docs.length;
                                j++)
                              if (categ ==
                                  dataSnapshot.data.docs[j].get('category'))
                                _buildCard(
                                    dataSnapshot.data.docs[j].get('name'),
                                    dataSnapshot.data.docs[j]
                                        .get('price')
                                        .toString(),
                                    dataSnapshot.data.docs[j].get('picture'),
                                    dataSnapshot.data.docs[j]
                                        .get('description'),
                                    dataSnapshot.data.docs[j].get('sizes')[0],
                                    false,
                                    false,
                                    context),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                },
              )),
        ],
      ),
    );
  }

  Widget _buildCard(String name, String price, String imgPath,
      String description, String list, bool added, bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetail(
                      sizelist: list,
                      assetPath: imgPath,
                      cookieprice: price,
                      cookiename: name,
                      description: description)));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            isFavorite
                                ? Icon(Icons.favorite, color: kPrimaryColor)
                                : Icon(Icons.favorite_border,
                                    color: kPrimaryColor)
                          ])),
                  Hero(
                      tag: imgPath,
                      child: Image.network(
                        imgPath,
                        fit: BoxFit.contain,
                        height: 150,
                        width: 160,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Text('Erreur de téléchargement d\'image');
                        },
                      )),
                  SizedBox(height: 10.0),
                  Text('${price} DHS',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Varela',
                          fontSize: 13.0)),
                  SizedBox(height: 10.0),
                  Text(name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 13.0)),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Icon(Icons.shopping_cart,
                                  color: kPrimaryColor, size: 12.0),
                            ),
                            Text('Ajouter au panier',
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0)),
                          ]))
                ]))));
  }

  void checkItemIncart(
      String productdescri, String size, BuildContext context) {
    if (AuthProvider.preferences
        .getStringList(AuthProvider.collectionCartlist)
        .contains(productdescri)) {
      Fluttertoast.showToast(msg: "Ce produit est déja dans votre panier");
      Navigator.pushReplacementNamed(context, "/cart");
    } else {
      addItemToCart(productdescri, size, context);
      Navigator.pushReplacementNamed(context, "/cart");
    }
  }

  addItemToCart(String productdescri, String size, BuildContext context) {
    List tempCartList =
        AuthProvider.preferences.getStringList(AuthProvider.collectionCartlist);
    tempCartList.add(productdescri);
    AuthProvider.firestore
        .collection(AuthProvider.collectionUser)
        .doc(AuthProvider.preferences.getString(AuthProvider.id))
        .update({
      AuthProvider.collectionCartlist: tempCartList,
    }).then((value) {
      Fluttertoast.showToast(msg: "Article est bien ajouté au panier");
      AuthProvider.preferences
          .setStringList(AuthProvider.collectionCartlist, tempCartList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Cart(
                    size: size,
                  )));
    });
  }
}
