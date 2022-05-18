import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/admin/dashboard.dart';
import 'package:shopjdidfirebase/compenants/rounded.button.dart';
import 'package:shopjdidfirebase/compenants/rounded_input_field.dart';
import 'package:shopjdidfirebase/const.dart';

class UploadItems extends StatefulWidget {
  @override
  _UploadItemsState createState() => _UploadItemsState();
}

class _UploadItemsState extends State<UploadItems> {
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  String name;
  double price;
  String picture;
  String description;
  String brand;
  int quantity = 0;
  String category;
  bool featured = true;
  bool uploading = false;
  bool sale = false;
  List<String> colors = ["red", "blue", "black", "green"];
  List<String> sizes = ["XS", "S", "M", "L", "XL"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("",
                style: TextStyle(
                  color: Colors.black,
                )),
            Text(
              "Admin",
              style: TextStyle(color: Colors.pink),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: size.height * 0.05,
                left: 0,
                child: Image.asset(
                  "images/user.png",
                  width: size.width * 1,
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Ajouter un produit",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child:
                        Image.asset("images/logo.png", width: size.width * 0.3),
                  ),
                  RoundedInputField(
                    text: "Nom du produit",
                    onchanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  RoundedInputField(
                    text: "Price",
                    onchanged: (value) {
                      setState(() {
                        price = double.parse(value);
                      });
                    },
                  ),
                  RoundedInputField(
                    text: "picture",
                    onchanged: (value) {
                      setState(() {
                        picture = value;
                      });
                    },
                  ),
                  RoundedInputField(
                    text: "Description",
                    onchanged: (value) {
                      description = value;
                    },
                  ),
                  RoundedInputField(
                    text: "Marque",
                    onchanged: (value) {
                      brand = value;
                    },
                  ),
                  RoundedInputField(
                    text: "Quantité",
                    onchanged: (value) {
                      quantity = int.parse(value);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Catégorie:",
                        style: TextStyle(color: kPrimaryColor, fontSize: 17),
                      ),
                      SizedBox(
                        width: size.width * 0.27,
                      ),
                      DropdownButton<String>(
                        value: category,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.pink),
                        underline: Container(
                          height: 2,
                          color: Colors.pink,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            category = newValue;
                          });
                        },
                        items: <String>[
                          'promo',
                          'caftan',
                          'djellaba',
                          'talon',
                          'accessoire',
                          'beauty',
                          'homme',
                          'enfant'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundedButton(
                    text: "Ajouter",
                    press: uploading ? null : () => saveItemInfo(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    // ignore: dead_code
  }

  void saveItemInfo() {
    final itemsRef = FirebaseFirestore.instance.collection("products");
    itemsRef.doc(productId).set({
      "name": name,
      "description": description,
      "price": price,
      "picture": picture,
      "brand": brand,
      "quantity": quantity,
      "category": category,
      "featured": featured,
      "sale": sale,
      "colors": colors,
      "sizes": sizes,
    });
    setState(() {
      Navigator.pop(context);
    });
  }
}
