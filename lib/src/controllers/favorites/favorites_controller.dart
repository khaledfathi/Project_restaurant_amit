import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/models/product_model.dart';

class FavoritesController {
  Future<List<ProductModel>> productInFavorites() async {
    List<String>? favorites =
        Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);
    List<ProductModel> products = [];
    if (favorites != null) {
      for (var productId in favorites) {
        await Globals.api.get("$API_GET_PRODUCT_BY_ID/$productId").then((response){
          products.add(ProductModel.fromMap(response.data));
        });
      }
    }
    return products;
  }
}
