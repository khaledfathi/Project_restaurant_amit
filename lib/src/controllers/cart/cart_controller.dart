import 'package:project_restaurant/core/core_export.dart';

class CartController {
 ///remove all data in shared preferences [CART] by replacing it with empty List
  Future<void> clearCart ()async{
    await Globals.sharedPreferences.setStringList(CART, []);
  }
}