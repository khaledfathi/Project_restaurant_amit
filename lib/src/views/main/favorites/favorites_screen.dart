import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_no_internet.dart';
import 'package:project_restaurant/src/controllers/favorites/cubit/favorites_ui_cubit.dart';
import 'package:project_restaurant/src/controllers/favorites/favorites_controller.dart';
import 'package:project_restaurant/src/controllers/internet_checker/cubit/internet_cubit.dart';
import 'package:project_restaurant/src/models/product_model.dart';
import 'package:project_restaurant/src/views/main/favorites/components/favorites_product_box.dart';

class FavoritesScreen extends StatefulWidget {
  //route
  static const String route = 'favorites';
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  //screen controller
  final FavoritesController _controller = FavoritesController();
  //favorite products list
  List<ProductModel> _favoriteProducts = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavoritesUiCubit(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Favorites"),
            centerTitle: true,
          ),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: BlocConsumer<InternetCubit, InternetState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is InternetConnected) {
                  return FutureBuilder(
                      future: _controller.productInFavorites(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          _favoriteProducts = snapshot.data!;
                          return BlocConsumer<FavoritesUiCubit,
                                  FavoritesUiState>(
                              builder: (context, state) {
                                return ListView(
                                  children:
                                      _productsBoxs(context, _favoriteProducts),
                                );
                                // return ListView.builder(
                                //   itemCount: favoriteProducts.length,
                                //   itemBuilder: (context, index) {
                                //     return FavoritesProductBox(
                                //       image: favoriteProducts[index].image!,
                                //       name: favoriteProducts[index].name!,
                                //       restaurantName: favoriteProducts[index].restaurantName!,
                                //       discount: favoriteProducts[index].discount!,
                                //       price: favoriteProducts[index].price!,
                                //       onTapAddToCart: () {},
                                //       onTapRemoveItem: () {
                                //         FavoritesUiCubit.get(context).removeFromFavorites( favoriteProducts[index].id!.toString());
                                //         print(state);
                                //       },
                                //     );
                                //   },
                                // );
                              },
                              listener: (context, state) {});
                        } else {
                          return const CustomLoading();
                        }
                      });
                } else {
                  return const CustomNoInternet();
                }
              },
            ),
          ),
        ));
  }

  List<Widget> _productsBoxs(
      BuildContext context, List<ProductModel> products) {
    List<Widget> producstList = [];
    products.asMap().forEach((index, product) {
      producstList.add(BlocConsumer<FavoritesUiCubit, FavoritesUiState>(
        listener: (context, state) {},
        builder: (context, state) {
          return FavoritesProductBox(
            image: product.image!,
            name: product.name!,
            restaurantName: product.restaurantName!,
            discount: product.discount!,
            price: product.price!,
            onTapAddToCart: () {},
            onTapRemoveItem: () async {
              _favoriteProducts.removeAt(index);
              FavoritesUiCubit.get(context)
                  .removeFromFavorites(product.id!.toString());
            },
          );
        },
      ));
    });
    return producstList;
  }
}
