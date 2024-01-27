import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';
import 'package:project_restaurant/src/views/success/success_screen.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial()); 
  static CheckoutCubit get(context)=> BlocProvider.of(context);

  Future<void> makeOrder(BuildContext context) async {
    emit(CheckOutLoading());
    //prepeare order 
    List cart = Globals.sharedPreferences.getStringList(CART) ?? [];
    Map orders = {'user_id': Auth.currentUser!.id, 'products': []};
    for (var element in cart) { 
      Map item = jsonDecode(element);
      orders['products'].add(
        {
          'product_id':  item['productId'],
          'quantity': item['quantity'],
        }
      );
    }
    //send order to backend server  
    await Globals.api.post( API_POST_ORDER, data: jsonEncode(orders));
    //clear cart
    Globals.sharedPreferences.setStringList(CART, []).then((_) {
      emit(CheckOutSuccuess());
      Navigator.pushNamed(context, SuccessScreen.route);
    });

  }
}
