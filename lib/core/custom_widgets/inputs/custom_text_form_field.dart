import 'package:flutter/material.dart';



class CustomTextFormField extends StatelessWidget {
  final String? labelText ;
  final IconData? suffixButtonIconData; 
  final void Function ()? onTapSuffixButton ;
  final Icon? suffixIcon  ; 
  final Color? suffixIconColor ; 
  final TextEditingController?    controller ;
  final void Function (String)? onChanged ;
  final void Function (String?)? onSaved; 
  final String? Function (String?)? validator; 
  final bool? obscureText; 
  final TextInputType? keyboardType ; 
  final bool? enabled;
  final bool? readOnly ; 

  const CustomTextFormField({super.key, 
    this.labelText, 
    this.suffixButtonIconData,
    this.onTapSuffixButton,
    this.suffixIcon,
    this.suffixIconColor,
    this.controller, 
    this.onChanged, 
    this.onSaved, 
    this.validator,
    this.obscureText , 
    this.keyboardType,
    this.enabled,
    this.readOnly
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(        
        controller: controller,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        enabled: enabled,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          suffix: InkWell(onTap: onTapSuffixButton, child: Icon(suffixButtonIconData, size: 24)),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          border: InputBorder.none,
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          errorBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}
