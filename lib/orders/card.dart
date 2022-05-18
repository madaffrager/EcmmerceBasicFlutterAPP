import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/compenants/rounded_input_field.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/counter/cart.counter.dart';

import '../const.dart';

class AddCreditCard extends StatefulWidget {
  final String adresseId;
  final double totalAmount;

  const AddCreditCard({Key key, this.adresseId, this.totalAmount})
      : super(key: key);

  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  String cc, exp, cvv;
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
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Montant total: ${widget.totalAmount} DHS.",
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
              RoundedInputField(
                onchanged: (value) {
                  cc = value;
                },
                text: "Numéro de carte",
                icon: Icons.credit_card,
              ),
              SizedBox(height: 10),
              RoundedInputField(
                onchanged: (value) {
                  exp = value;
                },
                text: "MM/AAAA",
                icon: Icons.credit_card,
              ),
              SizedBox(height: 10),
              RoundedInputField(
                onchanged: (value) {
                  cvv = value;
                },
                text: "CVV",
                icon: Icons.credit_card,
              ),
              SizedBox(height: 10),
              RoundedButton(
                press: () {
                  if (cc.isEmpty || exp.isEmpty || cvv.isEmpty) {
                  } else {
                    payezlacommande(cc, exp, cvv);
                  }
                },
                text: "Payez votre commande",
              )
            ],
          ),
        ),
      ),
    );
  }

  payezlacommande(String cc, String exp, String cvv) {
    String cardid = AuthProvider.preferences.getString(AuthProvider.id) +
        DateTime.now().millisecondsSinceEpoch.toString();
    addcreditcard(cardid, cc, exp, cvv);

    writeOrderDetailsforUser({
      AuthProvider.addressId: widget.adresseId,
      AuthProvider.total: widget.totalAmount,
      "orderBy": AuthProvider.preferences.getString(AuthProvider.id),
      AuthProvider.productid: AuthProvider.preferences
          .getStringList(AuthProvider.collectionCartlist),
      AuthProvider.paymentdetails: cardid,
      AuthProvider.ordertime: DateTime.now().millisecondsSinceEpoch.toString(),
      AuthProvider.isSuccess: true,
    });
    writeOrderDetailsforAdmin({
      AuthProvider.addressId: widget.adresseId,
      AuthProvider.total: widget.totalAmount.toString(),
      "orderBy": AuthProvider.preferences.getString(AuthProvider.id),
      AuthProvider.productid: AuthProvider.preferences
          .getStringList(AuthProvider.collectionCartlist),
      AuthProvider.paymentdetails: cardid,
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

  Future addcreditcard(String cardid, String cc, String exp, String cvv) {
    {
      AuthProvider.firestore
          .collection(AuthProvider.collectionUser)
          .doc(AuthProvider.preferences.getString(AuthProvider.id))
          .collection("cartes")
          .doc(cardid)
          .set({"numero": cc, "exp": exp, "cvv": cvv});
    }
  }
}
