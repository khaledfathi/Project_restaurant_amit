import 'package:flutter/material.dart';

class CustomListOfStars extends StatelessWidget {
  final double? starSize; 
  const CustomListOfStars({super.key,
    this.starSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ..._listOfStars(),
        const Text(
          '(10)',
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  List<Widget> _listOfStars({int count = 5}) {
    List<Widget> stars = [];
    for (var i = 0; i < count; i++) {
      stars.add( Icon(
        Icons.star,
        color: Colors.yellow,
        size: starSize ?? 14,
      ));
    }
    return stars;
  }
}
