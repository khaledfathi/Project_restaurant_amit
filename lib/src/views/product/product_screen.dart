import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/custom_widgets/buttons/custom_standard_button.dart';
import 'package:project_restaurant/core/states/favorites/product_on_category_favorites/product_on_category_favorites_cubit.dart';
import 'package:project_restaurant/src/controllers/product/product_args.dart';
import 'package:project_restaurant/src/controllers/product/product_controller.dart';
import 'package:project_restaurant/src/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  static const String route = 'product';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  //screen controller
  final ProductController _controller = ProductController();

  @override
  Widget build(BuildContext context) {
    ProductArgs args =
        ModalRoute.of(context)!.settings.arguments as ProductArgs;
    ProductModel product = args.product!;
    return Scaffold(
        appBar: AppBar(
          title: FittedBox(
            child: Text(product.name!),
          ),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          ],
        ),
        body: ListView(
          children: [
            /***** Product Image *****/
            SizedBox(
              height: 413,
              width: MediaQuery.sizeOf(context).width,
              child: Image.network(
                product.image!,
                fit: BoxFit.cover,
              ),
            ),
            /***** -END- Product Image *****/

            /***** Favorite *****/
            BlocConsumer<ProductOnCategoryFavoritesCubit,
                    ProductOnCategoryFavoritesState>(
                builder: (context, state) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => ProductOnCategoryFavoritesCubit.get(context).favoritesAction(product.id!.toString()),
                      iconSize: 36,
                      icon: _controller.isInFavorite(product.id.toString())
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border_outlined),
                    ),
                  );
                },
                listener: (context, state) {}),
            /***** -END- Favorite *****/

            /***** Product details *****/
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(product.restaurantName!,
                        style: const TextStyle(fontSize: 24)),
                  )),
                  Expanded(
                      child: FittedBox(
                    child: RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                          children:
                              _priceFormat(product.price!, product.discount!)),
                    ),
                  )),
                ],
              ),
            ),
            /***** -END- Product details *****/

            /***** Add to cart button *****/
            CustomStanderButton(
              text: 'Add to Cart',
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              onPressed: () {},
            ),
            /***** -END- Add to cart button *****/
          ],
        ));
  }

  List<TextSpan> _priceFormat(String price, String discount) {
    if (discount != '0') {
      double oldPrice = double.parse(price) + double.parse(discount);
      return <TextSpan>[
        TextSpan(
          text: '\$$oldPrice',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 24,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        TextSpan(
            text: '  \$$price',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
            )),
      ];
    }
    return <TextSpan>[
      TextSpan(
          text: '\$$price',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ))
    ];
  }
}
