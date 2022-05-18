import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/counter/cart.counter.dart';
import 'package:shopjdidfirebase/counter/total.dart';
import 'package:shopjdidfirebase/models/Product.dart';
import 'package:shopjdidfirebase/products/products.dart';
import 'package:shopjdidfirebase/user/address.dart';

class Cart extends StatefulWidget {
  final String size;

  const Cart({Key key, this.size}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double totalAmount;
  List sizes;
  @override
  void initState() {
    super.initState();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (AuthProvider.preferences
                  .getStringList(AuthProvider.collectionCartlist)
                  .length ==
              1) {
            Fluttertoast.showToast(msg: "Votre panier est vide");
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Address(totalAmount: totalAmount)));
          }
        },
        label: Text("Valider votre achat"),
        backgroundColor: kPrimaryColor,
        icon: Icon(Icons.navigate_next),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Products()));
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : Text(
                            "Prix Total: ${amountProvider.totalamount.toString()} DHS",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: AuthProvider.firestore
                .collection("products")
                .where("description",
                    whereIn: AuthProvider.preferences
                        .getStringList(AuthProvider.collectionCartlist))
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : snapshot.data.docs.length == 0
                      ? beginbuildingCart()
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            ItemModel model = ItemModel.fromJson(
                                snapshot.data.docs[index].data());
                            if (index == 0) {
                              totalAmount = 0;
                              totalAmount = model.price + totalAmount;
                            } else {
                              totalAmount = model.price + totalAmount;
                            }
                            if (index == snapshot.data.docs.length - 1) {
                              WidgetsBinding.instance.addPostFrameCallback((t) {
                                Provider.of<TotalAmount>(context, listen: false)
                                    .display(totalAmount);
                              });
                            }

                            return sourceInfo(model, context,
                                removeCartFunction: () =>
                                    removeItemFromUserCart(model.description));
                          },
                              childCount: snapshot.hasData
                                  ? snapshot.data.docs.length
                                  : 0),
                        );
            },
          ),
        ],
      ),
    );
  }

  beginbuildingCart() {
    return SliverToBoxAdapter(
      child: Card(
        color: kPrimaryLightColor,
        child: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_emoticon, color: Colors.white),
              Text("Votre Panier est vide!"),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String description) {
    List tempCartList =
        AuthProvider.preferences.getStringList(AuthProvider.collectionCartlist);
    tempCartList.remove(description);
    AuthProvider.firestore
        .collection(AuthProvider.collectionUser)
        .doc(AuthProvider.preferences.getString(AuthProvider.id))
        .update({
      AuthProvider.collectionCartlist: tempCartList,
    }).then((value) {
      Fluttertoast.showToast(msg: "Article est bien supprimé au panier");
      AuthProvider.preferences
          .setStringList(AuthProvider.collectionCartlist, tempCartList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
      totalAmount = 0;
      Navigator.pushReplacementNamed(context, "/cart");
    });
  }
}
