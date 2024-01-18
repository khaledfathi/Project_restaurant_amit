import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: MediaQuery.sizeOf(context).width,
      child: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
            color: Colors.amber, size: 250),
      ),
    );
  }
}
