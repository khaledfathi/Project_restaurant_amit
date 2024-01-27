import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_list_of_stars.dart';

class FavoritesProductBox extends StatelessWidget {
  final String image;
  final String name;
  final String restaurantName;
  final String discount;
  final String price;
  final void Function()? onTapRemoveItem;
  final void Function()? onTapAddToCart;
  const FavoritesProductBox(
      {super.key,
      required this.image,
      required this.name,
      required this.restaurantName,
      required this.discount,
      required this.price,
      this.onTapRemoveItem,
      this.onTapAddToCart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          height: 116,
          width: MediaQuery.sizeOf(context).width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              /***** Product Image ******/
              SizedBox(
                  width: 104,
                  height: double.infinity,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
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
                    width: 50,
                  )),
              /***** -END- Product Image ******/

              /***** Prodcut details coulmn ******/
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(restaurantName,
                              style: const TextStyle(
                                  color: Color.fromRGBO(155, 155, 155, 1),
                                  fontSize: 11)),
                          Text(
                            name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text('Discount :$discount \$',
                              style: const TextStyle(fontSize: 16)),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('$price\$',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const Expanded(
                                  flex: 2, child: CustomListOfStars()),
                            ],
                          )
                        ],
                      ))),
              /***** -END- Prodcut details coulmn ******/
            ],
          ),
        ),

        /***** Remove From Favorites X button ******/
        Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: onTapRemoveItem,
              child: const Icon(
                Icons.close,
                size: 30,
                color: Colors.grey,
              ),
            )),
        /***** -END- Remove From Favorites X button ******/

        /***** Add to cart icon ******/
        Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
                onTap: onTapAddToCart,
                child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.shopping_bag_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ))))
        /***** -END- Add to cart icon ******/
      ],
    );
  }
}
