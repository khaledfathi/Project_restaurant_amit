import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_no_internet.dart';
import 'package:project_restaurant/src/controllers/home/home_controller.dart';
import 'package:project_restaurant/src/views/main/home/components/home_restaurant_box.dart';
import 'package:project_restaurant/src/views/main/home/components/home_restaurants_on_category_row.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future _restaurants = HomeController().restaurantsData();
  late Stream _internetConnection ; 

  @override
  void initState() {
    _internetConnection = Globals.connection.onStatusChange; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //check internet state
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /***** Screen Header Image *****/
              SizedBox(
                width: double.infinity,
                height: 196,
                child: Image.asset(
                  HOME_FOOD_IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
              /***** -END- Screen Header Image *****/

              /***** Restaurants In Specific Category *****/
              StreamBuilder(
                  stream: _internetConnection,
                  builder: (context, internetConnectionSnapshot) {
                    debugPrint('HomeScreen : internet stream status = ${internetConnectionSnapshot.connectionState}');
                    if (internetConnectionSnapshot.connectionState == ConnectionState.active) {
                      if (internetConnectionSnapshot.data == InternetStatus.connected) {
                        return FutureBuilder(
                            future: _restaurants,
                            builder: (context, restaurantSnapshot) {
                              if (restaurantSnapshot.connectionState ==
                                  ConnectionState.done) {
                                return Column(
                                  children: _listOfRestaurantsOnCategory(
                                      restaurantSnapshot.data),
                                );
                              } else {
                                return const CustomLoading();
                              }
                            });
                      } else if (internetConnectionSnapshot.data == InternetStatus.disconnected) {
                        return const CustomNoInternet();
                      } else {
                        return const CustomLoading();
                      }
                    }
                    return const CustomLoading();
                  }),
              /***** Restaurants In Specific Category *****/

              /***** -END- Restaurants In Specific Category *****/
            ],
          ),
        ));
  }

  /// list of widgets of restaurants depend on its category as row
  List<Widget> _listOfRestaurantsOnCategory(List data) {
    List<Widget> restaurants = [];
    for (var elements in data) {
      restaurants.add(HomeRestaurantsInCategoryRow(
        restaurantCategoryName: elements[0]['category_name'],
        onTapViewAll: () => print("OK"),
        restaurants: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: elements.length,
          itemBuilder: (context, index) {
            return HomeRestaurantBox(
              restaurantName: elements[index]['name'],
              image: Image.network(
                elements[index]['image'],
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SizedBox(
                    height: 170,
                    child: Center(
                        child: LoadingAnimationWidget.discreteCircle(
                            color: Colors.amber, size: 60)),
                  );
                },
                fit: BoxFit.cover,
                height: 170,
              ),
            );
          },
        ),
      ));
    }
    return restaurants;
  }
}
