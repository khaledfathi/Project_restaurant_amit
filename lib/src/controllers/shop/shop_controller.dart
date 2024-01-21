import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/models/product_category_model.dart';

class ShopController {

  Future<List<ProductCategoryModel>> getCategories()async{
    List<ProductCategoryModel> productsCategories = [] ; 
    await Globals.api.get(API_GET_PRODUCT_CATEGORIES).then((response){
      //convert to model 
      for (var productCategory in response.data) {
        productsCategories.add(ProductCategoryModel.fromMap(productCategory));
      }
    });
    return productsCategories; 
  }
}