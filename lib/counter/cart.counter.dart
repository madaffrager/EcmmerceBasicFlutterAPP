import 'package:flutter/foundation.dart';
import 'package:shopjdidfirebase/config/config.dart';

class CartItemCounter extends ChangeNotifier {
  int _counter = AuthProvider.preferences
          .getStringList(AuthProvider.collectionCartlist)
          .length -
      1;
  int get count => _counter;
  Future<void> displayResult() async {
    int _counter = AuthProvider.preferences
            .getStringList(AuthProvider.collectionCartlist)
            .length -
        1;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
