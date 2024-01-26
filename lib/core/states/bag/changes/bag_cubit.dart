import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';

part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagInitial());
  static BagCubit get(context) => BlocProvider.of(context);

  Future<double> removeFromCard(int index) async {
    //read cart
    List<String> cart = Globals.sharedPreferences.getStringList(CART)!;
    //remove from cart
    cart.removeAt(index);

    //rebuild cart
    await Globals.sharedPreferences.setStringList(CART, cart);
    emit(BagChanged());
    
    //recalculate over all price
    double overAllPrice = 0;
    for (var element in cart) {
      Map data = jsonDecode(element);
      overAllPrice += double.parse(data['productPrice']) * int.parse(data['quantity']);
    }
    return overAllPrice;
  }

  ///change the selected product in cart quantity - on shared prefrences [CART] , return overAllPrice
  Future<double> changeQuantity({
    required int productIndex,
    required int quantity,
  }) async {
    //read cart
    List<String> cart = Globals.sharedPreferences.getStringList(CART)!;
    //modified product quantity
    Map selectedProduct = jsonDecode(cart[productIndex]);
    selectedProduct['quantity'] = quantity.toString();
    //update in cart
    cart[productIndex] = jsonEncode(selectedProduct);

    //rebuild cart in shared preference
    await Globals.sharedPreferences.setStringList(CART, cart);

    emit(BagChanged());
    //recalculate over all price
    cart = await Globals.sharedPreferences.getStringList(CART) ?? [];
    double overAllPrice = 0;
    for (var element in cart) {
      Map data = jsonDecode(element);
      overAllPrice +=
          double.parse(data['productPrice']) * int.parse(data['quantity']);
    }
    return overAllPrice;
  }

  void makeOrder (){
    List cart = Globals.sharedPreferences.getStringList(CART) ?? [] ; 
    Map orders = {'user_id': Auth.currentUser!.id , 'products':[]};
    for (var product in cart) {
      orders['products'].add( product);
    }
  }
}
