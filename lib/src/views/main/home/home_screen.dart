import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_lodaing.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_no_internet.dart';
import 'package:project_restaurant/core/states/internet_checker/internet/internet_cubit.dart';
import 'package:project_restaurant/src/controllers/home/home_controller.dart';
import 'package:project_restaurant/src/models/restaurant_model.dart';
import 'package:project_restaurant/src/views/main/home/components/home_restaurant_box.dart';
import 'package:project_restaurant/src/views/main/home/components/home_restaurants_on_category_row.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
              BlocConsumer<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state is InternetConnected) {
                      return FutureBuilder(
                          future: HomeController().restaurantsData(),
                          builder: (context, restaurantSnapshot) {
                            if (restaurantSnapshot.connectionState ==
                                ConnectionState.done) {
                              return Column(
                                children: _listOfRestaurantsOnCategory(
                                    restaurantSnapshot.data!),
                              );
                            } else {
                              return const CustomLoading();
                            }
                          });
                    }else if (state is InternetDisconnected){
                      return const CustomNoInternet();
                    }
                    return const CustomLoading();
                  },
                  listener: (context, state) {}),
              /***** Restaurants In Specific Category *****/

              /***** -END- Restaurants In Specific Category *****/
            ],
          ),
        ));
  }

  /// list of widgets of restaurants depend on its category as row
  List<Widget> _listOfRestaurantsOnCategory(List<List<RestaurantModel>> data) {
    List<Widget> restaurants = [];
    for (var elements in data) {
      /***** Restaurants category row *****/
      restaurants.add(HomeRestaurantsInCategoryRow(
        restaurantCategoryName: elements[0].categoryName,
        onTapViewAll: () => print("OK"),
        restaurants: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: elements.length,
          itemBuilder: (context, index) {
            /***** Restaurn box *****/
            return HomeRestaurantBox(
              restaurantName: elements[index].name,
              image: Image.network(
                elements[index].image!,
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
            /***** -END- Restaurn box *****/
          },
        ),
      ));
      /***** -END- Restaurants category row *****/
    }
    return restaurants;
  }
}
