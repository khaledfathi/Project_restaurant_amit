import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_password_visibility_state.dart';

class SignUpPasswordVisibilityCubit extends Cubit<SignUpPasswordVisibilityState> {
  SignUpPasswordVisibilityCubit() : super(SignUpHidePassword());

  static  SignUpPasswordVisibilityCubit get(context)=> BlocProvider.of(context); 

  bool _toggle= true ; 
  void toggleVisibility (){
    _toggle = !_toggle; 
    _toggle ? emit(SignUpHidePassword()) : emit(SignUpShowPassword()); 
  }
}