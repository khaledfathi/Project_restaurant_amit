import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'restaurants_state.dart';

///Get list of products by sending request to server 
class RestaurantsCubit extends Cubit<RestaurantsState> {
  RestaurantsCubit() : super(RestaurantsInitial());
  static RestaurantsCubit get(context) => BlocProvider.of(context);

  void getRestaurants() async {
    emit(RestaurantsLoading());
    //check internet
    if (await Globals.connection.hasInternetAccess) {
      await Globals.api
          .get(API_GET_RESTAURANT_INDEX , options: Options(validateStatus: (Status)=>true))
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection timedout'))
          .then((response) {
            if (response.statusCode == 200){//success 
              var data = response.data;
              print (data[1]);//debug 
              emit(RestaurantsSuccess());
            }else {
              emit(RestaurantsFail());
            }
      }).catchError((e){
            debugPrint('LoginCubit : gerRestaurants : exception : $e'); 
            emit(RestaurantsConnectionError());
      });
    }else{
      emit(RestaurantsNoInternet()); 
    }
  }
}
