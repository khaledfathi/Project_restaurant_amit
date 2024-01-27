import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_list_of_stars.dart';

class ProductsProductBox extends StatelessWidget {
  final String image;
  final String name;
  final String restaurantName;
  final String discount;
  final String price;
  final Icon? favoriteIcon;
  final void Function()? onTapProductImage;
  final void Function()? onTapFavorite;
  const ProductsProductBox(
      {super.key,
      required this.image,
      required this.name,
      required this.restaurantName,
      required this.discount,
      required this.price,
      this.onTapProductImage,
      this.onTapFavorite,
      this.favoriteIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 190,
          child: Stack(
            children: [
              /***** Product Image *****/
              SizedBox(
                  width: double.infinity,
                  height: 175,
                  child: InkWell(
                    onTap: onTapProductImage,
                    child: Image.network(
                      image,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return SizedBox(
                            height: 170,
                            child: Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                    color: Colors.amber, size: 60)),
                          );
                        }
                      },
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                  )),
              /***** -END- Product Image *****/

              /***** Favorite Button Icon******/
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                      onTap: onTapFavorite,
                      child: CircleAvatar(
                        child: favoriteIcon ??
                            const Icon(Icons.favorite_border_outlined),
                      ))),
              /***** -END- Favorite Button Icon******/
            ],
          ),
        ),

        /***** Restaurant Rate Starts*****/
        const Padding(
          padding: EdgeInsets.all(5),
          child: CustomListOfStars(),
        ),
        /***** -END- Restaurant Rate Starts*****/

        /***** Product Text Details ******/
        FittedBox(
          child: Text(
            restaurantName,
            style: const TextStyle(fontSize: 11),
          ),
        ),
        FittedBox(
            child: Text(name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18))),
        FittedBox(
            child: Text(
          'discount: $discount',
          style: const TextStyle(fontSize: 14),
        )),
        FittedBox(
            child: Text(
          'price: $price\$',
          style: const TextStyle(fontSize: 14),
        )),
        /***** -END- Product Text Details ******/
      ],
    );
  }
}
