import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  static const String route = 'no-internet'; 
  const NoInternetScreen ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('No Internet '),
      ),
    );
  }
}