import 'package:flutter/material.dart';
import 'package:project_restaurant/core/constants/general_const.dart';
import 'package:project_restaurant/core/core_export.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
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
              FutureBuilder(
                  future: _restaurants,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: _listOfRestaurantsOnCategory(snapshot.data),
                      );
                    } else {
                      return Text('ELSE');
                    }
                  })
              /***** Restaurants In Specific Category *****/

              /***** -END- Restaurants In Specific Category *****/
            ],
          ),
        ));
  }

  List<Widget> _listOfRestaurantsOnCategory(List data) {
    List<Widget> restaurants = [];
    for (var elements in data) {
      restaurants.add(HomeRestaurantsInCategoryRow(
        restaurantCategoryName: elements[0]['category_name'],
        onTapViewAll: () => print("OK"),
        restaurants: ListView.builder(
          itemCount: elements.length,
          itemBuilder: (context, index) {
            return HomeRestaurantBox(
              restaurantName: elements[index]['name'],
              image: Image.network(
                elements[index]['image'],
                fit: BoxFit.cover,
                height: 170,
              ),
            );
          },
          scrollDirection: Axis.horizontal,
        ),
      ));
    }
    return restaurants;
  }
}
