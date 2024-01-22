import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/states/favorites/product_on_category_favorites/product_on_category_favorites_cubit.dart';
import 'package:project_restaurant/src/controllers/products_on_category/product_on_category_controller.dart';
import 'package:project_restaurant/src/controllers/products_on_category/products_on_category_args.dart';
import 'package:project_restaurant/src/models/product_model.dart';
import 'package:project_restaurant/src/views/products_on_category/components/products_product_box.dart';

class ProductsOnCategoryScreen extends StatefulWidget {
  static const String route = "products-on-category";
  const ProductsOnCategoryScreen({super.key});

  @override
  State<ProductsOnCategoryScreen> createState() =>
      _ProductsOnCategoryStateScreen();
}

class _ProductsOnCategoryStateScreen extends State<ProductsOnCategoryScreen> {
  //screen controller
  final ProductOnCategoryController _controller = ProductOnCategoryController();

  @override
  Widget build(BuildContext context) {
    ProductOnCategoryArgs? args =
        ModalRoute.of(context)!.settings.arguments as ProductOnCategoryArgs?;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(args!.productCategoryName!,
            style: const TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _controller.getProductCategory(args.productCategoryId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<ProductModel> products = snapshot.data!;

              /***** Product  *****/
              return Container(
                  margin: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 300,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return BlocConsumer<ProductOnCategoryFavoritesCubit, ProductOnCategoryFavoritesState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return ProductsProductBox(
                              image: products[index].image!,
                              name: products[index].name!,
                              restaurantName: products[index].restaurantName!,
                              discount: products[index].discount!,
                              price: products[index].price!,
                              favoriteIcon: _setFavoriteIcon(
                                  products[index].id!.toString()),
                              onTapFavorite: () {
                                ProductOnCategoryFavoritesCubit.get(context).favoritesAction(
                                    products[index].id!.toString());
                              });
                        },
                      );
                    },
                  ));
              /***** -END- Product  *****/
            } else {
              return const CustomLoading();
            }
          }),
    );
  }

  /// check if product in favorites
  bool _isInFavorite(String productId) {
    List<String>? favorites =
        Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);
    if (favorites != null) {
      for (var favoriteId in favorites) {
        if (favoriteId == productId) return true;
      }
    }
    return false;
  }

  ///set favorite icon
  Icon? _setFavoriteIcon(String productId) {
    return _isInFavorite(productId)
        ? const Icon(Icons.favorite, color: Colors.red)
        : null;
  }
}
