import 'package:flutter/material.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/src/controllers/favorites/favorites_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites"),
        ),
        body: FutureBuilder(
            future: _controller.productInFavorites(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List favoriteProducts = snapshot.data!;
                return ListView.builder(
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    return  Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.network(favoriteProducts[index]['image'],width: 50,),
                            Text('Name : ${favoriteProducts[index]['name']}'),
                            Text('Restaurant : ${favoriteProducts[index]['restaurant_name']}'),
                            Text('Discount : ${favoriteProducts[index]['discount']}'),
                            Text('Price : ${favoriteProducts[index]['price']}'),
                          ],
                        ));
                  },
                );
              } else {
                return const CustomLoading();
              }
            }));
  }
}
