import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/views/products_on_category/products_on_category_screen.dart';

class ProductController {
  /// check if this productId in list of shared preferences [PRODUCT_FAVORITES]
  bool isInFavorite(String productId) {
    List<String>? favoritesProducts =
        Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);
    for (var favoriteProductId in favoritesProducts!) {
      if (favoriteProductId == productId) {
        return true;
      }
    }
    return false;
  }

  /// add map {productId , quantity} to list on shared preferences [CART]
  Future<void> addToCart(BuildContext context, String productId,
      String quantity, String productPrice, String discount) async {
    Map<String, String> data = {
      'productId': productId,
      'quantity': quantity.toString(),
      'price': double.parse(productPrice).toString(),
      'totalPrice': ((double.parse(productPrice) - double.parse(discount)) * double.parse(quantity)) .toString(),
      'discount': discount.toString()
    };
    //get old CART List
    List<String>? cart = Globals.sharedPreferences.getStringList(CART);
    //add new to cart
    if (cart == null) {
      await Globals.sharedPreferences
          .setStringList(CART, [jsonEncode(data)]).then((value) =>
              Navigator.popUntil(context,
                  ModalRoute.withName(ProductsOnCategoryScreen.route)));
    } else {
      cart.add(jsonEncode(data));
      await Globals.sharedPreferences.setStringList(CART, cart).then((value) =>
          Navigator.popUntil(
              context, ModalRoute.withName(ProductsOnCategoryScreen.route)));
    }
  }
}
