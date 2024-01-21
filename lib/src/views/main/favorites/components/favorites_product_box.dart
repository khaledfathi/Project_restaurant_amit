import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
              // Product Image
              SizedBox(
                  width: 104,
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
              //Prodcut details coulmn
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //restaurant that provide this product
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
                                child: Text('$price\$',
                                    style: const TextStyle(fontSize: 14)),
                              ),
                              Expanded(
                                  child: Row(children: [
                                ..._listOfStars(),
                                const Text(' (10)'),
                              ])),
                            ],
                          )
                        ],
                      ))),
            ],
          ),
        ),
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
        Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: onTapAddToCart,
              child: const Icon(
                Icons.shopping_bag_rounded,
                size: 30,
                color: Colors.red,
              ),
            ))
      ],
    );
  }

  List<Widget> _listOfStars({int count = 5}) {
    List<Widget> stars = [];
    for (var i = 0; i < count; i++) {
      stars.add(const Icon(
        Icons.star,
        color: Colors.yellow,
        size: 14,
      ));
    }
    return stars;
  }
}
