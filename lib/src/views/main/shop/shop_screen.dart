import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  //route 
  static const String route = 'shop';
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Text('Shop Screen'),
      ),
    );
  }
}