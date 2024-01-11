import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';
import 'package:project_restaurant/src/models/user_model.dart';
import 'package:project_restaurant/src/views/main/main_screen.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context)=> BlocProvider.of(context); 

  static String msg =''; 

  void login ({required BuildContext context ,required String email , required String password})async{
    emit(LoginLoading());
    //check internet connection
    if (await Globals.connection.hasInternetAccess) {
      //Do sign up
      await Globals.api.post(API_POST_LOGIN , data: {
        "email": email,
        "password": password,
      }).then((response) {
        print (response.data); 
        if (response.data['operation']) {
          emit(LoginSuccess());
          UserModel user = UserModel(
            name: response.data['user']['name'], 
            email: email,
            image : response.data['user']['image'],
            token : response.data['token']
          );           
          Globals.sharedPreferences.setString(CURRENT_USER, jsonEncode(response.data['user'])); 
          Globals.sharedPreferences.setBool(IS_LOGIN, true); 
          Globals.sharedPreferences.setString(API_TOKEN, response.data['token']); 
          Auth.setCurrentUser(user); 
          Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.route , (route)=>false); 
          msg = 'Login Successfuly ';
        } else {
          emit(LoginFail());
          msg = response.data['msg'];
        }
      });
    } else {
      emit(LoginNoInternet());
      msg = 'No Internet , Pleass Check your connection';
    }
  }
}
