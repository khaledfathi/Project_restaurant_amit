import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'login_email_validation_state.dart';

class LoginEmailValidationCubit extends Cubit<LoginEmailValidationState> {
  LoginEmailValidationCubit() : super(LoginEmailValidationInitial());

  static LoginEmailValidationCubit get(context)=> BlocProvider.of(context); 

  void validateEmail (String email){
    Validation validation = Validation(email).required().email().validate(); 
    validation.isValid ? emit(LoginValidEmail()) : emit(LoginInvalidEmail()); 
  }
}
