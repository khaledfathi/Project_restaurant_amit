import 'package:project_restaurant/core/core_export.dart';

class ProductController {
  bool isInFavorite (String productId){
    List<String>? favoritesProducts =  Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);
    for (var favoriteProductId in favoritesProducts!) {
      if (favoriteProductId == productId){
        return true ; 
      }
    } 
    return false; 
  }
}