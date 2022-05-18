import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

class TotalAmount extends ChangeNotifier {
  double _totalamount = 0;
  double get totalamount => _totalamount;
  display(double m) async {
    _totalamount = m;
    await Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      notifyListeners();
    });
  }
}
