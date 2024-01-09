import 'package:flutter/material.dart';

class CustomLineButton extends StatelessWidget {
  final String? label ; 
  final void Function ()? onPressed ;
  final EdgeInsets? margin ; 
  const CustomLineButton({super.key, 
    this.label, 
    this.onPressed, 
    this.margin
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 10 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed:onPressed, child: Text(label??'' , style:TextStyle( color:Color.fromRGBO(34, 34, 34, 1)))),
          IconButton(
              onPressed:onPressed,
              icon: const Icon(
                Icons.arrow_forward,
                weight: 10,
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
