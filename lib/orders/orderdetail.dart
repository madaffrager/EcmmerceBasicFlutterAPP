import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shopjdidfirebase/compenants/appbar.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/models/Product.dart';
import 'package:shopjdidfirebase/models/user.dart';
import 'package:shopjdidfirebase/splashPage.dart';
import 'package:shopjdidfirebase/user/address.dart';
import 'package:shopjdidfirebase/user/user.dart';

import '../const.dart';

String getOrderID = '';

class OrderDetails extends StatelessWidget {
  final String orderID;

  const OrderDetails({Key key, this.orderID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getOrderID = orderID;
    return Scaffold(
      appBar: MyAppbar(),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: AuthProvider.firestore
              .collection(AuthProvider.collectionUser)
              .doc(AuthProvider.preferences.getString(AuthProvider.id))
              .collection(AuthProvider.collectionOrder)
              .doc(orderID)
              .get(),
          builder: (c, snapshot) {
            Map dataMap;
            if (snapshot.hasData) {
              dataMap = snapshot.data.data();
            }
            return snapshot.hasData
                ? Container(
                    child: Column(children: [
                      StatusBanner(status: dataMap[AuthProvider.isSuccess]),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: EdgeInsets.all(4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              dataMap[AuthProvider.total].toString() + "DHS",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Date :   " +
                              DateFormat("dd MMMM, yyyy - hh:mm").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(dataMap["ordertime"]))),
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      Divider(
                        height: 2.0,
                      ),
                      FutureBuilder<QuerySnapshot>(
                          future: AuthProvider.firestore
                              .collection("products")
                              .where("description",
                                  whereIn: dataMap[AuthProvider.productid])
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
                      Divider(height: 2),
                      FutureBuilder<DocumentSnapshot>(
                          future: AuthProvider.firestore
                              .collection(AuthProvider.collectionUser)
                              .doc(AuthProvider.preferences
                                  .getString(AuthProvider.id))
                              .collection(AuthProvider.subCollectionAddress)
                              .doc(dataMap[AuthProvider.addressId])
                              .get(),
                          builder: (c, snp) {
                            return snp.hasData
                                ? ShippingDetails(
                                    model:
                                        AddressModel.fromJson(snp.data.data()))
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          })
                    ]),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class StatusBanner extends StatelessWidget {
  final bool status;

  const StatusBanner({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData;
    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? msg = "Validée" : msg = "Annulée";
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [kPrimaryLightColor, Colors.white, kPrimaryLightColor]),
          borderRadius: BorderRadius.circular(10)),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Container(
              child: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'Commande placée',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 5,
          ),
          CircleAvatar(
            radius: 8,
            backgroundColor: kPrimaryLightColor,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.black,
                size: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShippingDetails extends StatelessWidget {
  final AddressModel model;

  const ShippingDetails({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Adresse de livraison:",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 90),
          width: width * 0.8,
          child: Table(
            children: [
              TableRow(children: [
                KeyText(
                  msg: 'Nom',
                ),
                Text(model.nom),
              ]),
              TableRow(children: [
                KeyText(
                  msg: 'Adresse',
                ),
                Text(model.rue),
              ]),
              TableRow(children: [
                KeyText(
                  msg: 'Ville',
                ),
                Text(model.ville),
              ]),
              TableRow(children: [
                KeyText(
                  msg: 'Code Postal',
                ),
                Text(model.zip),
              ]),
              TableRow(children: [
                KeyText(
                  msg: 'Numéro Mobile',
                ),
                Text(model.mobile),
              ]),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: InkWell(
              onTap: () {
                confirmeduserOrderreceived(context, getOrderID);
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.pink,
                      kPrimaryLightColor,
                      Colors.pink,
                    ]),
                    borderRadius: BorderRadius.circular(10)),
                width: width - 40,
                height: 50,
                child: Center(
                  child: Text(
                    "Confirmer la réception du commande",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void confirmeduserOrderreceived(BuildContext context, String mOrderID) {
    AuthProvider.firestore
        .collection(AuthProvider.collectionUser)
        .doc(AuthProvider.preferences.getString(AuthProvider.id))
        .collection(AuthProvider.collectionOrder)
        .doc(mOrderID)
        .delete();
    mOrderID = '';
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
    Fluttertoast.showToast(msg: "Commande bien traitée");
  }
}
