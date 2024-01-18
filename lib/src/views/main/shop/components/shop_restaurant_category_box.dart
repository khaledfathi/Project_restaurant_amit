import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_restaurant/src/controllers/products_on_category/products_on_category_args.dart';
import 'package:project_restaurant/src/views/products_on_category/products_on_category_screen.dart';

class ShopRestaurantCategoryBox extends StatelessWidget {
  final int productCategoryId ; 
  final String  productName ; 
  final String productImage ; 
  const ShopRestaurantCategoryBox({super.key,
    required this.productCategoryId, 
    required this.productName,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductsOnCategoryScreen.route,
          arguments: ProductOnCategoryArgs(
              productCategoryId: productCategoryId)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child: Text(
                productName, 
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )),
          Expanded(
            child: Image.network(
              productImage,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return SizedBox(
                    height: 170,
                    child: Center(
                        child: LoadingAnimationWidget.discreteCircle(
                            color: Colors.amber, size: 60)),
                  );
                }
              },
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
