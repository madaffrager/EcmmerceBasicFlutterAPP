import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/appbar.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/models/Product.dart';
import 'package:shopjdidfirebase/orders/orderdetail.dart';

import '../const.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: AuthProvider.firestore
            .collection(AuthProvider.collectionUser)
            .doc(AuthProvider.preferences.getString(AuthProvider.id))
            .collection(AuthProvider.collectionOrder)
            .snapshots(),
        builder: (c, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (c, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                      orderID: snapshot.data.docs[index].id,
                                    )));
                      },
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("products")
                              .where("description",
                                  whereIn: snapshot.data.docs[index]
                                      .get(AuthProvider.productid))
                              .get(),
                          builder: (context, AsyncSnapshot asyncSnapshot) {
                            return asyncSnapshot.hasData
                                ? Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          kPrimaryLightColor,
                                          Colors.white,
                                          kPrimaryLightColor
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),
                                    height:
                                        asyncSnapshot.data.docs.length * 190.0,
                                    child: ListView.builder(
                                        itemCount:
                                            asyncSnapshot.data.docs.length,
                                        itemBuilder: (c, i) {
                                          ItemModel model = ItemModel.fromJson(
                                              asyncSnapshot.data.docs[i]
                                                  .data());
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 20, top: 5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 160,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            model.picture),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          model.name,
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Marque : " + model.brand,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.7)),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          model.price
                                                                  .toString() +
                                                              " DHS",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }))
                                : Center();
                          }),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
