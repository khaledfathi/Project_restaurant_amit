import 'package:flutter/material.dart';
import 'package:project_restaurant/core/constants/general_const.dart';
import 'package:project_restaurant/src/views/main/home/components/home_restaurants_on_category_row.dart';

class HomeScreen extends StatelessWidget {
  static const String route = 'home'; 
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /***** Screen Header Image *****/
            SizedBox(
              width: double.infinity,
              height: 196,
              child: Image.asset(HOME_FOOD_IMAGE , fit: BoxFit.cover,),
            ),
            /***** -END- Screen Header Image *****/

            /***** Restaurants In Specific Category *****/
            HomeRestaurantsInCategoryRow(),
            HomeRestaurantsInCategoryRow(),
            /***** Restaurants In Specific Category *****/

          /***** -END- Restaurants In Specific Category *****/
          ],
        ),
      ),
    );
  }
}