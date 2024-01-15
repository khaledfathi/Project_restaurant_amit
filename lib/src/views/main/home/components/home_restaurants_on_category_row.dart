import 'package:flutter/material.dart';

class HomeRestaurantsInCategoryRow extends StatelessWidget {
  final String? restaurantCategoryName;
  final void Function()? onTapViewAll;
  final ListView? restaurants ;
  const HomeRestaurantsInCategoryRow({
    super.key,
    this.restaurantCategoryName,
    this.onTapViewAll,
    this.restaurants,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 320,
      width: MediaQuery.sizeOf(context).width,
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
                            child: Text(
                              restaurantCategoryName ?? 'box title',
                              textAlign: TextAlign.left,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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

          /***** Restaurants Boxs *****/
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 255,
            width: MediaQuery.of(context).size.width,
            child: restaurants,
          ),
          /***** -END- Restaurants Boxs *****/
        ],
      ),
    );
  }
}
