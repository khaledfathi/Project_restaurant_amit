import 'package:project_restaurant/core/core_export.dart';

class FavoritesController {
  Future<List> productInFavorites() async {
    List<String>? favorites =
        Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);
    List products = [];
    if (favorites != null) {
      for (var productId in favorites) {
        await Globals.api.get("$API_GET_PRODUCT_BY_ID/$productId").then((response){
          products.add(response.data);
        });
      }
    }
    return products;
  }
}
