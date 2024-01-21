import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/models/restaurant_model.dart';

class HomeController {
  Future<List<List<RestaurantModel>>> restaurantsData() async {
    int categoriesCount = 0;
    List<List<RestaurantModel>> data = [];
    //get restaurant categories count
    await Globals.api
        .get(API_GET_RESTAURANT_CATEGORIES,
            options: Options(
                validateStatus: (_) => true, receiveTimeout: Duration.zero))
        .timeout(const Duration(seconds: 30),
            onTimeout: () => throw TimeoutException('Connection timedout'))
        .then((response) {
      if (response.statusCode == 200) {
        categoriesCount = response.data.length;
      }
    }).catchError((e) => debugPrint('HomeController : restaurantData : $e'));

    //create list of restaurants for each category
    for (var i = 1; i <= categoriesCount; i++) {
      await Globals.api
          .get('$API_GET_RESTAURANT_FILTER_BY_CATEGORY/$i',
              options: Options(
                  validateStatus: (_) => true, receiveTimeout: Duration.zero))
          .timeout(const Duration(seconds: 30),
              onTimeout: () => throw TimeoutException('Connection timedout'))
          .then((response) {
        //get restaurants and convert to RestaurantModel
        List<RestaurantModel> restaurants = [];
        for (var restaurant in response.data) {
          restaurants.add(RestaurantModel.fromMap(restaurant));
        }
        data.add(restaurants);
        restaurants = [];
      }).catchError((e) => debugPrint('HomeController : restaurantData : $e'));
    }
    return data;
  }
}
