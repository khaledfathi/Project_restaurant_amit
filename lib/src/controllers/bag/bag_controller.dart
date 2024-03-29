import 'dart:convert';
import 'package:project_restaurant/core/core_export.dart';

class BagController {
  ///remove all data in shared preferences [CART] by replacing it with empty List
  Future<void> clearBag() async {
    await Globals.sharedPreferences.setStringList(CART, []);
  }

  Future<Map> getBagData() async {
    // bage data structure
    Map bagData = {'cart': [], 'overAllPrice': 0};
    //cart data from shared preferences
    List data = Globals.sharedPreferences.getStringList(CART) ?? [];
    //init total invoice
    double overAllPrice = 0;
    // cart list
    List<Map> cart = [];

    for (var item in data) {
      Map data = jsonDecode(item);
      Map product = {};
      await Globals.api
          .get('$API_GET_PRODUCT_BY_ID/${data["productId"]}')
          .then((response) {
        product = response.data;
      });
      overAllPrice += double.parse(data['totalPrice']);
      cart.add({
        //order details on shared prefreneces
        'productId': data['productId'],
        'quantity': data['quantity'],
        'price': data['price'],
        'priceWithDiscount': (double.parse(data['price']) - double.parse(data['discount']) ).toString(),
        'totalPrice': double.parse(data['totalPrice']).toString() ,
        //Product data from api
        'restaurantName': product['restaurant_name'],
        'productName': product['name'],
        'image': product['image'],
      });
    }
    bagData['cart'] = cart;
    bagData['overAllPrice'] = overAllPrice;
    return bagData;
  }


}
