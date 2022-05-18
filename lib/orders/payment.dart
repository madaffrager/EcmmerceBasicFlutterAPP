import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/counter/cart.counter.dart';
import 'package:shopjdidfirebase/orders/card.dart';

class PaymentPage extends StatefulWidget {
  final String adresseId;
  final double totalAmount;

  const PaymentPage({Key key, this.adresseId, this.totalAmount})
      : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: new BoxDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Les méthodes de paiement acceptées",
                  style: TextStyle(color: kPrimaryColor, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/logo.png",
                  width: 150,
                ),
              ),
              SizedBox(height: 10),
              RoundedButton(
                press: () => addOrderDetails(),
                text: "Paiement à la livraison",
              ),
              SizedBox(height: 10),
              RoundedButton(
                press: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCreditCard(
                              adresseId: widget.adresseId,
                              totalAmount: widget.totalAmount,
                            ))),
                text: "Paiement par carte",
              )
            ],
          ),
        ),
      ),
    );
  }

  addOrderDetails() {
    writeOrderDetailsforUser({
      AuthProvider.addressId: widget.adresseId,
      AuthProvider.total: widget.totalAmount,
      "orderBy": AuthProvider.preferences.getString(AuthProvider.id),
      AuthProvider.productid: AuthProvider.preferences
          .getStringList(AuthProvider.collectionCartlist),
      AuthProvider.paymentdetails: 'Cash On Delivery',
      AuthProvider.ordertime: DateTime.now().millisecondsSinceEpoch.toString(),
      AuthProvider.isSuccess: true,
    });
    writeOrderDetailsforAdmin({
      AuthProvider.addressId: widget.adresseId,
      AuthProvider.total: widget.totalAmount.toString(),
      "orderBy": AuthProvider.preferences.getString(AuthProvider.id),
      AuthProvider.productid: AuthProvider.preferences
          .getStringList(AuthProvider.collectionCartlist),
      AuthProvider.paymentdetails: 'Cash On Delivery',
      AuthProvider.ordertime: DateTime.now().millisecondsSinceEpoch.toString(),
      AuthProvider.isSuccess: true,
    }).whenComplete(() => {emptyCartNow()});
  }

  emptyCartNow() {
    AuthProvider.preferences
        .setStringList(AuthProvider.collectionCartlist, ["garbageValue"]);
    List tempList =
        AuthProvider.preferences.getStringList(AuthProvider.collectionCartlist);
    FirebaseFirestore.instance
        .collection("users")
        .doc(AuthProvider.preferences.getString(AuthProvider.id))
        .update({
      AuthProvider.collectionCartlist: tempList,
    }).then((value) {
      AuthProvider.preferences
          .setStringList(AuthProvider.collectionCartlist, tempList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });

    Fluttertoast.showToast(msg: 'Félicitations pour votre commande.');
    Navigator.pushReplacementNamed(context, "/home");
  }

  Future writeOrderDetailsforUser(Map<String, dynamic> data) async {
    await AuthProvider.firestore
        .collection(AuthProvider.collectionUser)
        .doc(AuthProvider.preferences.getString(AuthProvider.id))
        .collection(AuthProvider.collectionOrder)
        .doc(AuthProvider.preferences.getString(AuthProvider.id) +
            data['ordertime'])
        .set(data);
  }

  Future writeOrderDetailsforAdmin(Map<String, dynamic> data) async {
    await AuthProvider.firestore
        .collection(AuthProvider.collectionOrder)
        .doc(AuthProvider.preferences.getString(AuthProvider.id) +
            data['ordertime'])
        .set(data);
  }
}
