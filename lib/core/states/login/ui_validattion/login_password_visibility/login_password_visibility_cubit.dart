import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_password_visibility_state.dart';

///toggle bool to use in login UI to show/hide password field
class LoginPasswordVisibilityCubit extends Cubit<LoginPasswordVisibilityState> {
  LoginPasswordVisibilityCubit() : super(LoginPasswordVisibilityInitial());
  
  static LoginPasswordVisibilityCubit get(context) => BlocProvider.of(context); 
  
  bool _toggle= true ; 
  void toggleVisibility (){
    _toggle = !_toggle; 
    _toggle ? emit(LoginHidePassword()) : emit(LoginShowPassword()); 
  }
}
