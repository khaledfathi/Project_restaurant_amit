import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  //route 
  static const String route  = 'favorites'; 
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Favorites Screen'),
      ),
    );
  }
}