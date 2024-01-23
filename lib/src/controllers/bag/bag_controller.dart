import 'dart:convert';

import 'package:project_restaurant/core/core_export.dart';

class BagController {
  ///remove all data in shared preferences [CART] by replacing it with empty List
  Future<void> clearBag() async {
    await Globals.sharedPreferences.setStringList(CART, []);
  }

  List<Map> getBagData() {
    List data = Globals.sharedPreferences.getStringList(CART) ?? [];
    List<Map> cart = [];
    for (var item in data) {
      cart.add(jsonDecode(item));
    }
    return cart;
  }
}
