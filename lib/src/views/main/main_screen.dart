import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  //route 
  static const String route = 'main'; 
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Main Screen'),
      ),
    );
  }
}