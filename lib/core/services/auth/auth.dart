import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/models/user_model.dart';
import 'package:project_restaurant/src/views/login/login_screen.dart';
import 'package:project_restaurant/src/views/sign_up/sign_up_screen.dart';

class Auth {
  static UserModel? currentUser ; 
  
  static setCurrentUser (UserModel user){
    currentUser = user; 
  }

  static logout (BuildContext context){
    Globals.sharedPreferences.setBool(IS_LOGIN, false); 
    Globals.sharedPreferences.remove(CURRENT_USER); 
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.route, (route) => false);
  }
}