import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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

  static LoginCubit get(context) => BlocProvider.of(context);

  static String msg = '';

  void login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    emit(LoginLoading());
    //check internet connection
    if (await Globals.connection.hasInternetAccess) {
      //Do Login
      await Globals.api
          .post(
            API_POST_LOGIN,
            options: Options(validateStatus: (status)=>true),//all HTTP codes are acceptable
            data: {
              "email": email,
              "password": password,
            },
          )
          .timeout(const Duration(seconds: (8)) , onTimeout: ()=> throw TimeoutException('Connection Timedout'))
          .then((response) {
            if (response.statusCode == 200) {
              if (response.data['operation']) {
                emit(LoginSuccess());
                Map currentUser = response.data['user']; 
                currentUser['token'] = response.data['token']; 
                Globals.sharedPreferences.setString(CURRENT_USER, jsonEncode(currentUser));
                Globals.sharedPreferences.setBool(IS_LOGIN, true);
                Globals.sharedPreferences.setString(API_TOKEN, response.data['token']);
                Auth.setCurrentUser( UserModel.fromMap(currentUser)); 
                msg = 'Login Successfuly ';
                Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.route, (route) => false);
              } else {
                msg = response.data['msg'];
                emit(LoginFail());
              }
            }
          }).catchError((e){
            msg = 'Connection Error'; 
            emit(LoginConnectionError());
          });
    } else {
      msg = 'No Internet , Pleass Check your connection';
      emit(LoginNoInternet());
    }
  }
}
