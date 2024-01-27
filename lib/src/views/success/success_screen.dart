import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/views/main/main_screen.dart';

class SuccessScreen extends StatelessWidget {
  static const String route = 'success';
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(SUCCESS_IMAGE),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Text(
                  'Success',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                child: Text(
                  'Your order will be delivered soon.\nThank you for choosing our app!',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
          Expanded(
            flex: 2,
              child: Stack(
            children: [
              Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: CustomStanderButton(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    text: 'CONTINUE SHOPPING',
                    width: MediaQuery.of(context).size.width * 0.95,
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, MainScreen.route, (route) => false),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
