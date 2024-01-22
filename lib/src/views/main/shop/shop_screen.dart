import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_no_internet.dart';
import 'package:project_restaurant/core/states/internet_checker/internet/internet_cubit.dart';
import 'package:project_restaurant/src/controllers/shop/shop_controller.dart';
import 'package:project_restaurant/src/models/product_category_model.dart';
import 'package:project_restaurant/src/views/main/shop/components/shop_products_categories_box.dart';

class ShopScreen extends StatefulWidget {
  //route
  static const String route = 'shop';

  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  //screen controller
  final ShopController _controller = ShopController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text(
            'Product Categories',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is InternetConnected) {
                return FutureBuilder(
                    future: _controller.getCategories(),
                    builder: (context, categorySnapshot) {
                      if (categorySnapshot.connectionState ==
                          ConnectionState.done) {
                        List<ProductCategoryModel> productCategory = categorySnapshot.data!;
                        return Container(
                          margin: const EdgeInsets.only(top: 30),
                          /***** List of restaurants categories*****/
                          child: ListView.builder(
                            itemCount: productCategory.length,
                            itemBuilder: (context, index) {
                              return Container(
                                clipBehavior: Clip.antiAlias,
                                height: 100,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                /***** Product Category Box *****/
                                child: ShopProductsCategoriesBox(
                                    productCategoryId: productCategory[index].id!,
                                    productCategoryName: productCategory[index].name!,
                                    productCategoryImage: productCategory[index].image!),
                                /***** -END- Product Category Box *****/
                              );
                            },
                          ),
                          /***** -END- List of restaurants categories*****/
                        );
                      } else {
                        return const CustomLoading();
                      }
                    });
              } else if (state is InternetDisconnected) {
                return const CustomNoInternet();
              } else {
                return const CustomLoading();
              }
            },
          ),
        ));
  }
}
