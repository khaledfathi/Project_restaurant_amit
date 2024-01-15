import 'package:flutter/material.dart';
import 'package:project_restaurant/src/views/main/home/components/home_restaurant_box.dart';

class HomeRestaurantsInCategoryRow extends StatelessWidget {
  final String? title ; 
  final void Function()? onTapViewAll; 
  final int? restaurantsCount; 
  const HomeRestaurantsInCategoryRow({super.key, 
    this.title, 
    this.onTapViewAll , 
    this.restaurantsCount, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.red,
      height: 320,
      child: Column(
        children: [
          /***** header Box *****/
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                        height: 50,
                        child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text( title ?? 'box title',
                            textAlign: TextAlign.left,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )))),
                Expanded(
                    child: InkWell(
                        onTap: onTapViewAll,
                        child: const Text(
                          ' View all',
                          textAlign: TextAlign.right,
                        ))),
              ],
            ),
          ),
          /***** -END- header Box *****/
          HomeRestaurantBoxBuilder(),
          /***** Restaurants Boxs *****/

       /***** -END- Restaurants Boxs *****/
        ],
      ),
    );
  }
}
