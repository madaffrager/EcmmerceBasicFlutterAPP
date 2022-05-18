import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/appbar.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/models/Product.dart';
import 'package:shopjdidfirebase/products/singleproduct.dart';
import 'package:shopjdidfirebase/user/cart.dart';

import 'bottombar.dart';

class Products extends StatefulWidget {
  User user;
  Products({this.user});
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLoggedIn = false;

  @override
  void initState() {
    isLoggedIn = false;
    widget.user = null;
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          Text('Categories',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.red,
              labelColor: kPrimaryColor,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 25.0),
              unselectedLabelColor: kPrimaryLightColor,
              tabs: [
                Tab(
                  child: Text('En Promo',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
                Tab(
                  child: Text('HOMME',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
                Tab(
                  child: Text('CAFTAN',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
                Tab(
                  child: Text('DJELLABA',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
                Tab(
                  child: Text('ESCARPINS',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
                Tab(
                  child: Text('ACCESSOIRES',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
                Tab(
                  child: Text('MOROCCAN BEAUTY',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
                Tab(
                  child: Text('ENFANTS',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                      )),
                ),
              ]),
          Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                SingleProduct(categ: "promo"),
                SingleProduct(
                  categ: "homme",
                ),
                SingleProduct(
                  categ: "caftan",
                ),
                SingleProduct(
                  categ: "djellaba",
                ),
                SingleProduct(
                  categ: "talon",
                ),
                SingleProduct(categ: "accessoire"),
                SingleProduct(
                  categ: "beauty",
                ),
                SingleProduct(
                  categ: "enfant",
                ),
              ])),
          SizedBox(
            height: 30,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Cart()));
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Row(
      children: [
        Container(
          height: 170,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(model.picture), fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  model.name,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: removeCartFunction,
                  child: Icon(
                    Icons.delete,
                    color: kPrimaryColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Marque : " + model.brand,
              style:
                  TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.7)),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  model.price.toString() + " DHS",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Quantité : 1",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}
