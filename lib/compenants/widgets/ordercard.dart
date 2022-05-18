import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopjdidfirebase/const.dart';
import 'package:shopjdidfirebase/models/Product.dart';
import 'package:shopjdidfirebase/orders/orderdetail.dart';

int counter = 0;

class OrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  const OrderCard({Key key, this.itemCount, this.data, this.orderID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Route route;
        if (counter == 0) {
          counter = counter + 1;
          route = MaterialPageRoute(
              builder: (c) => OrderDetails(
                    orderID: orderID,
                  ));
        }
        Navigator.push(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimaryLightColor, Colors.white, kPrimaryLightColor]),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: itemCount * 190.0,
        child: ListView.builder(itemBuilder: (c, index) {
          ItemModel model = ItemModel.fromJson(data[index].data());
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              children: [
                Container(
                  height: 160,
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
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Marque : " + model.brand,
                      style: TextStyle(
                          fontSize: 13, color: Colors.black.withOpacity(0.7)),
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
                          model.price.toString() + " DHS",
                          style: TextStyle(fontSize: 16),
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
        }),
      ),
    );
  }
}
