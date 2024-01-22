import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_no_internet.dart';
import 'package:project_restaurant/core/states/favorites/favorites_remove/favorites_remove_cubit.dart';
import 'package:project_restaurant/core/states/internet_checker/internet/internet_cubit.dart';
import 'package:project_restaurant/src/controllers/favorites/favorites_controller.dart';
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
        create: (context) => FavoritesRemoveCubit(),
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
                          return BlocConsumer<FavoritesRemoveCubit,
                                  FavoritesRemoveState>(
                              builder: (context, state) {
                                return ListView(
                                  children:
                                      _productsBoxs(context, _favoriteProducts),
                                );
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
      producstList.add(BlocConsumer<FavoritesRemoveCubit, FavoritesRemoveState>(
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
              FavoritesRemoveCubit.get(context)
                  .removeFromFavorites(product.id!.toString());
            },
          );
        },
      ));
    });
    return producstList;
  }
}
