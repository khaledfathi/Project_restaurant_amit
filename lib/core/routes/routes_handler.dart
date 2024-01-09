// Route generator 
import 'package:flutter/material.dart';
import 'package:project_restaurant/src/views/login/login_screen.dart';
import 'package:project_restaurant/src/views/page_not_found/page_not_found_screen.dart';
import 'package:project_restaurant/src/views/sign_up/sign_up_screen.dart';

class RouteHandler {
   static Route<dynamic> generateRoutes (RouteSettings setting){
    switch(setting.name!){
      case SignUpScreen.route :  return MaterialPageRoute(builder: (context)=>const SignUpScreen());
      case LoginScreen.route :  return MaterialPageRoute(builder: (context)=>const LoginScreen());
      default : return MaterialPageRoute(builder: (_)=>const PageNotFound()); 
    }
  }
}
