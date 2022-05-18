import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopjdidfirebase/compenants/appbar.dart';
import 'package:shopjdidfirebase/compenants/widebutton.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/counter/change.address.dart';
import 'package:shopjdidfirebase/counter/total.dart';
import 'package:shopjdidfirebase/models/user.dart';
import 'package:shopjdidfirebase/orders/payment.dart';
import 'package:shopjdidfirebase/user/addnewaddres.dart';

class AddressShow extends StatefulWidget {
  @override
  _AddressShowState createState() => _AddressShowState();
}

class _AddressShowState extends State<AddressShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbar(),
        backgroundColor: Color(0xFFFCFAF8),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addadress()));
          },
          label: Text("Ajouter une adresse"),
          backgroundColor: kPrimaryColor,
          icon: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Liste de vos adresses:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            ),
            Consumer<AddressChanger>(
              builder: (context, address, c) {
                return Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: AuthProvider.firestore
                        .collection(AuthProvider.collectionUser)
                        .doc(
                            AuthProvider.preferences.getString(AuthProvider.id))
                        .collection(AuthProvider.subCollectionAddress)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.data.docs.length == 0
                              ? noAdresscard()
                              : ListView.builder(
                                  itemCount: snapshot.data.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return AddressCard(
                                      currentIndex: address.count,
                                      value: index,
                                      addressId: snapshot.data.docs[index].id,
                                      model: AddressModel.fromJson(
                                          snapshot.data.docs[index].data()),
                                    );
                                  },
                                );
                    },
                  ),
                );
              },
            )
          ],
        ));
  }

  noAdresscard() {
    return Card(
      color: kPrimaryLightColor,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_location,
              color: Colors.black,
            ),
            Text("Vous n'avez pas d'adresse."),
            Text("Ajoutez une adresse !"),
          ],
        ),
      ),
    );
  }
}

class AddressCard extends StatefulWidget {
  final AddressModel model;
  final String addressId;
  final int currentIndex;
  final int value;

  const AddressCard(
      {Key key, this.model, this.addressId, this.currentIndex, this.value})
      : super(key: key);
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Provider.of<AddressChanger>(context, listen: false)
            .displayResult(widget.value);
      },
      child: Card(
        color: kPrimaryLightColor,
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: Colors.pink,
                  onChanged: (val) {
                    Provider.of<AddressChanger>(context, listen: false)
                        .displayResult(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: screenwidth * 0.8,
                      child: Table(
                        children: [
                          TableRow(children: [
                            KeyText(
                              msg: 'Nom',
                            ),
                            Text(widget.model.nom),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'Adresse',
                            ),
                            Text(widget.model.rue),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'Ville',
                            ),
                            Text(widget.model.ville),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'Code Postal',
                            ),
                            Text(widget.model.zip),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'Numéro Mobile',
                            ),
                            Text(widget.model.mobile),
                          ]),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            widget.value == Provider.of<AddressChanger>(context).count
                ? Container()
                : Container(),
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  final String msg;

  const KeyText({Key key, this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
