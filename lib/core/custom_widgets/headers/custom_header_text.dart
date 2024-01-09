import 'package:flutter/material.dart';

class CustomHeaderText extends StatelessWidget {
  final String title ; 
  final EdgeInsets? margin; 
  const CustomHeaderText({super.key, 
    required this.title,
    this.margin, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin:margin ?? const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.only(left: 10),
      child: Text( title,
        style: const TextStyle(fontSize: 30 , fontWeight: FontWeight.bold),
      ),
    );
  }
}