import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/const.dart';
import 'singleproduct.dart';
import 'bottombar.dart';

class ProductDetail extends StatefulWidget {
  final description, assetPath, cookieprice, cookiename, sizelist;

  ProductDetail(
      {this.description,
      this.assetPath,
      this.cookieprice,
      this.cookiename,
      this.sizelist});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String optionvalue;
  int qte;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qte = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Image.asset(
          'images/logo.png',
          fit: BoxFit.fill,
          height: 80,
          alignment: FractionalOffset.centerRight,
        ),
        actions: <Widget>[],
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Hero(
            tag: widget.assetPath,
            child: Image.network(widget.assetPath,
                height: 260.0, width: 100.0, fit: BoxFit.contain)),
        SizedBox(height: 20.0),
        Center(
          child: Text("${widget.cookieprice} DHS",
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor)),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(widget.cookiename,
              style: TextStyle(
                  color: kPrimaryColor, fontFamily: 'Varela', fontSize: 24.0)),
        ),
        SizedBox(height: 10.0),
        Center(
            child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: kPrimaryColor),
                child: Center(
                    child: GestureDetector(
                  onTap: () {
                    SingleProduct().checkItemIncart(
                        widget.description, optionvalue, context);
                  },
                  child: Text(
                    'Ajouter au panier',
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )))),
        SizedBox(height: 20.0),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       "Taille: ",
        //       style: TextStyle(color: Colors.pink, fontSize: 17),
        //     ),
        //     SizedBox(
        //       width: MediaQuery.of(context).size.width * 0.3,
        //     ),
        //     widget.sizelist == "XS"
        //         ? DropdownButton<String>(
        //             value: optionvalue,
        //             icon: const Icon(Icons.arrow_downward),
        //             iconSize: 24,
        //             elevation: 16,
        //             style: const TextStyle(color: Colors.pink),
        //             underline: Container(
        //               height: 2,
        //               color: Colors.pink,
        //             ),
        //             onChanged: (String newValue) {
        //               setState(() {
        //                 optionvalue = newValue;
        //               });
        //             },
        //             items: <String>[
        //               'XS',
        //               'S',
        //               'M',
        //               'L',
        //               'XL',
        //               'XXL',
        //             ].map<DropdownMenuItem<String>>((String value) {
        //               return DropdownMenuItem<String>(
        //                 value: value,
        //                 child: Text(value),
        //               );
        //             }).toList(),
        //           )
        //         : Text("spadrill")
        //   ],
        // ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 16.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 20.0),
        /*  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  if (qte > 1) {
                    setState(() {
                      qte--;
                    });
                  }
                },
                icon: Icon(Icons.remove,
                    size: 15, color: Colors.black.withOpacity(0.5))),
            SizedBox(
              width: 10,
            ),
            Text(
              qte.toString(),
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    qte++;
                  });
                },
                icon: Icon(Icons.add,
                    size: 15, color: Colors.black.withOpacity(0.5))),
          ],
        ),*/
        SizedBox(height: 40.0),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SingleProduct()
              .checkItemIncart(widget.description, optionvalue, context);
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
