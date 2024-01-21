import 'package:project_restaurant/core/constants/api_const.dart';
import 'package:project_restaurant/core/globals/globals.dart';
import 'package:project_restaurant/src/models/product_model.dart';

class ProductOnCategoryController {
  Future<List<ProductModel>> getProductCategory(int productCategoryId) async {
    List<ProductModel> productsList = [];
    await Globals.api
        .get('$API_GET_PRODUCT_FILTER_BY_CATEGROY/$productCategoryId')
        .then((response) {
      for (var product in response.data) {
        productsList.add(ProductModel.fromMap(product));
      }
    });
    return productsList;
  }
}
