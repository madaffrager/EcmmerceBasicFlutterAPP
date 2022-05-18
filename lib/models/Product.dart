import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String name;
  String picture;
  String description;
  String category;
  String brand;
  int quantity;
  double price;
  bool sale;
  bool featured;
  List colors;
  List sizes;
  ItemModel(
      this.name,
      this.picture,
      this.description,
      this.price,
      this.brand,
      this.category,
      this.quantity,
      this.featured,
      this.sale,
      this.colors,
      this.sizes);
  ItemModel.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    picture = data['picture'];
    description = data['description'];
    category = data['category'];
    brand = data['brand'];
    quantity = data['quantity'];
    price = data['price'];
    sale = data['sale'];
    featured = data['featured'];
    colors = data['colors'];
    sizes = data['sizes'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['picture'] = this.picture;
    data['description'] = this.description;
    data['category'] = this.category;
    data['brand'] = this.brand;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['sale'] = this.sale;
    data['featured'] = this.featured;
    data['colors'] = this.colors;
    data['sizes'] = this.sizes;
    return data;
  }
}
