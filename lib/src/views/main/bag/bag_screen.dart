import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/controllers/cart/cart_controller.dart';

class BagScreen extends StatefulWidget {
  //route
  static const String route = 'bag';
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  //screen controller
  final CartController _controller = CartController();
  //cart data
  late List _cartData;

  @override
  Widget build(BuildContext context) {
    _cartData = Globals.sharedPreferences.getStringList(CART) ?? [];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.clearCart();
                });
              },
              child: Text('Clear Cart'),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _cartData.length,
              itemBuilder: (context, index) {
                Map product = jsonDecode(_cartData[index]);
                return Container(
                  child: Column(children: [
                    Text(product['productId']),
                    Text(product['quantity']),
                    Text('---------'),
                  ]),
                );
              },
            )),
          ],
        ));
  }
}
