import 'package:flutter/material.dart';

class BagScreen extends StatelessWidget {
  //route 
  static const String route = 'bag';
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('BagScreen'),
      ),
    );
  }
}