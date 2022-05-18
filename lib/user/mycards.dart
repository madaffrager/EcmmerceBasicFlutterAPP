import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/appbar.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/const.dart';

class CreditCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: _buildTitleSection(
                    title: "Vos méthodes de paiement:", subTitle: "")),
          )),
          StreamBuilder<QuerySnapshot>(
            stream: AuthProvider.firestore
                .collection(AuthProvider.collectionUser)
                .doc(AuthProvider.preferences.getString(AuthProvider.id))
                .collection("cartes")
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildCreditCard(
                            color: Colors.blueGrey,
                            cardExpiration:
                                snapshot.data.docs[index].get("exp"),
                            cardHolder: AuthProvider.preferences
                                .getString(AuthProvider.name),
                            cardNumber:
                                snapshot.data.docs[index].get("numero")),
                        childCount: snapshot.data.docs.length,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }

  // Build the title section
  Column _buildTitleSection({@required title, @required subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 10.0),
          child: Text(
            '$title',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: TextStyle(fontSize: 21, color: Colors.black45),
          ),
        )
      ],
    );
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 8);
  }

  Card _buildCreditCard(
      {@required Color color,
      @required String cardNumber,
      @required String cardHolder,
      @required String cardExpiration}) {
    String newcard = replaceCharAt(cardNumber, 4, 'XXXXXXXX');
    return Card(
      elevation: 4.0,
      color: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(cardNumber),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '$newcard',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'Titulaire du carte',
                  value: cardHolder,
                ),
                _buildDetailsBlock(
                    label: 'Date d\'expiration', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildLogosBlock(String cardNumber) {
    String v = cardNumber.substring(0, 1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "images/contact_less.png",
          height: 20,
          width: 18,
        ),
        v == "4"
            ? Image.asset(
                "images/visa.png",
                height: 50,
                width: 50,
              )
            : Image.asset(
                "images/mastercard.png",
                height: 50,
                width: 50,
              ),
      ],
    );
  }

  Column _buildDetailsBlock({@required String label, @required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$label',
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
