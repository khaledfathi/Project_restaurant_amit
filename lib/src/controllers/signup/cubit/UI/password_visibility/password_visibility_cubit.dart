import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(HidePassword());

  static  PasswordVisibilityCubit get(context)=> BlocProvider.of(context); 

  bool _toggle= true ; 
  void toggleVisibility (){
    _toggle = !_toggle; 
    _toggle ? emit(HidePassword()) : emit(ShowPassword()); 
  }
}