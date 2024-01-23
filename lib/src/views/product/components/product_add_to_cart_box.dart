
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:project_restaurant/core/custom_widgets/buttons/custom_standard_button.dart';

class ProductAddToCartBox extends StatelessWidget {
  final int cartInitValue ; 
  final void Function() onPressAddToCart;
  final void Function(int quantity) onChange;
  const ProductAddToCartBox({super.key, 
    this.cartInitValue = 1,
    required this.onPressAddToCart,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /***** Title *****/
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Add To Cart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          /***** -END- Title *****/

          /***** Quantity SpinBox *****/
          Expanded(
              child: Center(
                child: 
                Padding(padding: const EdgeInsets.all(20) ,
                 child: SpinBox(
                  value: cartInitValue.toDouble(),
                  onChanged: (value)=> onChange(value.toInt()),
                  min: 1,   
                  readOnly: true,
                  textStyle: const TextStyle(fontSize: 18),
                  enableInteractiveSelection: false,
                )),
          )),
          /***** -END- Quantity SpinBox *****/

          /***** Add to cart button *****/
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: CustomStanderButton(
                    text: 'Add to Cart',
                    onPressed: onPressAddToCart,
                  ),
                )
              ],
            ),
          )
          /***** -END- Add to cart button *****/

        ],
      ),
    );
  }
}
