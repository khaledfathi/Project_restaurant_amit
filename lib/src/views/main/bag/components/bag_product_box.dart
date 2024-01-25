import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BagProductBox extends StatelessWidget {
  final String image; 
  final String productName; 
  final String restaurantName; 
  final String quantity; 
  final String price; 
  final void Function()? onTapRemoveFromBag; 
  const BagProductBox({super.key,
    required this.image,
    required this.productName, 
    required this.restaurantName, 
    required this.quantity,
    required this.price,
    required this.onTapRemoveFromBag 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: SizedBox(
            height: 130,
            width: 104,
            child: Row(
              children: [
                /***** Product Image******/
                Image.network(
                  image,
                  width: 104,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return SizedBox(
                        height: 104,
                        child: Center(
                            child: LoadingAnimationWidget.discreteCircle(
                                color: Colors.amber, size: 60)),
                      );
                    }
                  },
                ),
                /***** -END- Product Image******/

                /***** Product Details ******/
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            productName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: FittedBox(
                            child: Text(
                          restaurantName
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SpinBox(
                          value: double.parse(quantity),
                          readOnly: true,
                          min: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                        ),
                        // child: FittedBox(
                            // child:
                            //     Text(' + $quantity - ')
                        // ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.close)),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '$price\$',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
                /***** -END- Product Details ******/
              ],
            )));
  }
}
