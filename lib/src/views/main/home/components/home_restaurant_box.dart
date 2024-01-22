import 'package:flutter/material.dart';
import 'package:project_restaurant/core/constants/general_const.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_list_of_stars.dart';

class HomeRestaurantBox extends StatelessWidget {
  final String? restaurantName;
  final IconData? favoriteIcon;
  final void Function()? onTapFavoriteIcon;
  final Widget? image; 
  const HomeRestaurantBox(
      {super.key,
      this.restaurantName,
      this.favoriteIcon,
      this.onTapFavoriteIcon,
      this.image      
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          /***** Restaurant Image *****/
          Stack(
            clipBehavior: Clip.none,
            children: [
              image ?? Image.asset(
                NO_IMAGE ,
                fit: BoxFit.cover,
                height: 170,
              ),
              Positioned(
                  bottom: -10,
                  right: -10,
                  child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                          child: Icon(favoriteIcon ??
                              Icons.favorite_border_outlined)))),
            ],
          ),
          /***** -END- Restaurant Image *****/

          /***** Restaurant Rate Starts*****/
          const Padding(
            padding:  EdgeInsets.all(5),
            child:  CustomListOfStars(),
          ),
          /***** -END- Restaurant Rate Starts*****/

          /***** Restaurant Name*****/
          Container(
            height: 55,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FittedBox(
              child: Text(
                restaurantName?? 'restautant name',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )
          /***** -END- Restaurant Name*****/
        ],
      ),
    );
  }
}
