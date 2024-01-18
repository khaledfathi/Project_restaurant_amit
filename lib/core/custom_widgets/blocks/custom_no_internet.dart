import 'package:flutter/material.dart';
import 'package:project_restaurant/core/constants/general_const.dart';

class CustomNoInternet extends StatelessWidget {
  const CustomNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(children: [
        Image.asset(NO_INTERNET_IMAGE),
        const FittedBox(
            child: Text(
          'No Connection ,please check your internet',
          style: TextStyle(color: Colors.red),
        )),
      ]),
    );
  }
}
