import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  static const String appname = 'Luna';
  static SharedPreferences preferences;
  static User user;
  static FirebaseAuth auth;
  static FirebaseFirestore firestore;
  static String collectionUser = "users";
  static String collectionOrder = "orders";
  static String collectionCartlist = "userCart";
  static String subCollectionAddress = "adresse";
  static String sizeList = "userCart";

  static final String name = "name";
  static final String id = "id";
  static final String email = "email";
  static final String gender = "gender";
  static final String lastname = "lastname";
  static final String addressId = "adresseid";
  static final String total = "total";
  static final String productid = "productid";
  static final String paymentdetails = "payments";
  static final String ordertime = "ordertime";
  static final String isSuccess = "isSuccess";
}
