import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_no_internet.dart';

class ShopScreen extends StatefulWidget {
  //route
  static const String route = 'shop';

  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future _restaurantsCategories;
  late Stream _internetConnection;

  @override
  void initState() {
    _internetConnection = Globals.connection.onStatusChange;
    _restaurantsCategories = Globals.api.get(API_GET_RESTAURANT_CATEGORIES);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: StreamBuilder(
            stream: _internetConnection,
            builder: (context, snapshot) {
              debugPrint(
                  'ShopScreen : internet stream status = ${snapshot.connectionState}');
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data == InternetStatus.connected) {
                  return FutureBuilder(
                      future: _restaurantsCategories,
                      builder: (context, categorySnapshot) {
                        if (categorySnapshot.connectionState ==
                            ConnectionState.done) {
                          List restaurantCategories =
                              categorySnapshot.data.data;
                          return Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: ListView.builder(
                              itemCount: restaurantCategories.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 100,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: InkWell(
                                    onTap: () {print('OK');},
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: FittedBox(
                                            child: Text(
                                              restaurantCategories[index]['name'],
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        )),
                                        Expanded(
                                          child: Image.network(
                                            restaurantCategories[index]['image'],
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return SizedBox(
                                                  height: 170,
                                                  child: Center(
                                                      child:
                                                          LoadingAnimationWidget
                                                              .discreteCircle(
                                                                  color: Colors
                                                                      .amber,
                                                                  size: 60)),
                                                );
                                              }
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const CustomLoading();
                        }
                      });
                } else {
                  return const CustomNoInternet();
                }
              } else {
                return const CustomLoading();
              }
            }));
  }
}
