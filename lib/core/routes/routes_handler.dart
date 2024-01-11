// Route generator 
import 'package:flutter/material.dart';
import 'package:project_restaurant/src/views/login/login_screen.dart';
import 'package:project_restaurant/src/views/main/bag/bag_screen.dart';
import 'package:project_restaurant/src/views/main/favorites/favorites_screen.dart';
import 'package:project_restaurant/src/views/main/home/home_screen.dart';
import 'package:project_restaurant/src/views/main/main_screen.dart';
import 'package:project_restaurant/src/views/main/profile/profile_screen.dart';
import 'package:project_restaurant/src/views/main/shop/shop_screen.dart';
import 'package:project_restaurant/src/views/no_internet/no_internet_screen.dart';
import 'package:project_restaurant/src/views/page_not_found/page_not_found_screen.dart';
import 'package:project_restaurant/src/views/sign_up/sign_up_screen.dart';

class RouteHandler {
   static Route<dynamic> generateRoutes (RouteSettings setting){
    switch(setting.name!){
      case SignUpScreen.route :  return MaterialPageRoute(builder: (context)=>const SignUpScreen() , settings: setting);
      case LoginScreen.route :  return MaterialPageRoute(builder: (context)=>const LoginScreen() , settings: setting);
      case MainScreen.route :  return MaterialPageRoute(builder: (context)=>const MainScreen() , settings: setting);
      
      /***** Main Screen -> Sub Screens *****/
      case ShopScreen.route :  return MaterialPageRoute(builder: (context)=>const ShopScreen() , settings: setting);
      case ProfileScreen.route :  return MaterialPageRoute(builder: (context)=>const ProfileScreen() , settings: setting);
      case HomeScreen.route :  return MaterialPageRoute(builder: (context)=>const HomeScreen() , settings: setting);
      case FavoritesScreen.route :  return MaterialPageRoute(builder: (context)=>const FavoritesScreen() , settings: setting);
      case BagScreen.route :  return MaterialPageRoute(builder: (context)=>const BagScreen() , settings: setting);
      /***** -END- Main Screen -> Sub Screens *****/

      case NoInternetScreen.route :  return MaterialPageRoute(builder: (context)=>const NoInternetScreen() , settings: setting);
      default : return MaterialPageRoute(builder: (_)=>const PageNotFound() , settings: setting); 
    }    
  }
}
