import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/compenants/appbar.dart';
import 'package:shopjdidfirebase/compenants/dialog/errordialog.dart';
import 'package:shopjdidfirebase/compenants/rounded_input_field.dart';
import 'package:shopjdidfirebase/config/config.dart';
import 'package:shopjdidfirebase/models/user.dart';

import '../const.dart';

class Addadress extends StatefulWidget {
  @override
  _AddadressState createState() => _AddadressState();
}

class _AddadressState extends State<Addadress> {
  String nom;
  String mobile;
  String rue;
  String ville;
  String zip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbar(),
        backgroundColor: Color(0xFFFCFAF8),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (nom.isNotEmpty &&
                rue.isNotEmpty &&
                mobile.isNotEmpty &&
                zip.isNotEmpty &&
                ville.isNotEmpty) {
              final model = AddressModel(
                nom: nom,
                ville: ville,
                mobile: mobile,
                zip: zip,
                rue: rue,
              ).toJson();
              AuthProvider.firestore
                  .collection(AuthProvider.collectionUser)
                  .doc(AuthProvider.preferences.getString(AuthProvider.id))
                  .collection(AuthProvider.subCollectionAddress)
                  .doc(DateTime.now().millisecondsSinceEpoch.toString())
                  .set(model)
                  .then((value) {
                final snack =
                    SnackBar(content: Text("Nouvelle adresse enregistrée."));
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pushNamed(context, '/adresse');
              });
            } else {
              showDialog(
                  context: context,
                  builder: (c) {
                    ErrorAlertDialog(
                      message: 'Corrigez vos informations',
                    );
                  });
            }
          },
          label: Text("Valider"),
          backgroundColor: kPrimaryColor,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Adresse de livraison:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              RoundedInputField(
                text: "Nom complet",
                icon: Icons.person,
                onchanged: (value) {
                  setState(() {
                    nom = value;
                  });
                },
              ),
              RoundedInputField(
                text: "Adresse de livraison",
                icon: Icons.home,
                onchanged: (value) {
                  setState(() {
                    rue = value;
                  });
                },
              ),
              RoundedInputField(
                text: "Ville",
                icon: Icons.location_city,
                onchanged: (value) {
                  setState(() {
                    ville = value;
                  });
                },
              ),
              RoundedInputField(
                text: "Code Postal",
                icon: Icons.location_history,
                onchanged: (value) {
                  setState(() {
                    zip = value;
                  });
                },
              ),
              RoundedInputField(
                text: "Numéro mobile",
                icon: Icons.mobile_friendly,
                onchanged: (value) {
                  setState(() {
                    mobile = value;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
