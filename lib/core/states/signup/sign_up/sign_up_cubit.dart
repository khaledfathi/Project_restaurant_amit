import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/controllers/login/login_args.dart';
import 'package:project_restaurant/src/views/login/login_screen.dart';

part 'sign_up_state.dart';

//Do SignUp by sending request to server 
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);
  static String msg = '';

  Future<void> signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    emit(SignUpLoading());
    //check internet connection
    if (await Globals.connection.hasInternetAccess) {
      //Do sign up
      await Globals.api
          .post(API_POST_USER_STORE, data: {
            "name": name,
            "email": email,
            "password": password,
          })
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection timedout'))
          .then((response) {
            if (response.statusCode == 200) {
              if (response.data['operation']) {
                emit(SignUpSuccess());
                msg = 'Sign Up Complete Successfuly ';
                Navigator.pushNamed(context, LoginScreen.route,
                    arguments: LoginArgs(email: email, password: password));
              } else {
                emit(SignUpFail());
                msg = response.data['errors'][0];
              }
            }
          }).catchError((e){
            msg= 'Connection error'; 
            emit(SignUpConnectionError()); 
          });
    } else {
      emit(SignUpNoInternet());
      msg = 'No Internet , Pleass Check your connection';
    }
  }
}
