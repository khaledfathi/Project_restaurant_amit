import 'package:flutter/material.dart';

class CustomStanderButton extends StatelessWidget {
  final String? text ;   
  final void Function()? onPressed ; 
  final EdgeInsets? margin;
  final double? height ;
  final double? width;
  const CustomStanderButton({super.key, 
    this.text,
    this.onPressed,
    this.margin,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?? 48,
      width: width?? double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xffDB3022),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(211, 38, 38, 0.25),
              offset: Offset(0, 4),
              blurRadius: 8),
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        textColor: Colors.white,
        child: Text(text??'Click Me' , style: const TextStyle(fontSize: 14),),
      ),
    );
  }
}
