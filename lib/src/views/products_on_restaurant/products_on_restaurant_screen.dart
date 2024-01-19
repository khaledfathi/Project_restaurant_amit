import 'package:flutter/material.dart';

class ProductsOnRestaurantScreen extends StatefulWidget {
  static const String route = "products-on-restaurant";
  const ProductsOnRestaurantScreen({super.key});

  @override
  State<ProductsOnRestaurantScreen> createState() => _ProductsOnRestaurantScreenState();
}

class _ProductsOnRestaurantScreenState extends State<ProductsOnRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products On Restaurant'),
      ),
    );
  }
}