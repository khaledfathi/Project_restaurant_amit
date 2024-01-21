import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetInitial());
  static InternetCubit get(context)=> BlocProvider.of(context);

  void connectionListen (){
  Globals.connection.onStatusChange.listen((status) {
    switch (status) {
      case InternetStatus.connected:
       emit(InternetConnected()) ;
        break;
      case InternetStatus.disconnected: 
        emit(InternetDisconnected());
      default: 
    } 
   });
  }
}
