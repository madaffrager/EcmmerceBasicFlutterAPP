import 'package:flutter/foundation.dart';

class ItemQuantity with ChangeNotifier {
  int _numberitems = 0;
  int get numberitems => _numberitems;
  display(int no) {
    _numberitems = no;
    notifyListeners();
  }
}
