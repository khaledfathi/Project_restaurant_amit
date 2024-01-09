import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/views/login/login_screen.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  
  static SignUpCubit get(context) => BlocProvider.of(context);
  static String msg = '';

  Future<void> signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    emit(Loading());
    //check internet connection
    if (await Globals.connection.hasInternetAccess) {
      //Do sign up
      await Globals.api.post(API_POST_USER_STORE, data: {
        "name": name,
        "email": email,
        "password": password,
      }).then((response) {
        if (response.data['operation']) {
          emit(Success());
          msg = 'Sign Up Complete Successfuly ';
          Navigator.pushNamed(context, LoginScreen.route);
        } else {
          emit(Fail());
          msg = response.data['errors'][0];
        }
      });
    } else {
      emit(NoInternet());
      msg = 'No Internet , Pleass Check your connection';
    }
  }
}
