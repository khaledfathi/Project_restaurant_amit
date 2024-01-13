import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/services/validation/validation.dart';

part 'sign_up_email_validation_state.dart';

class SignUpEmailValidationCubit extends Cubit<SignUpEmailValidationState> {
  SignUpEmailValidationCubit() : super(SignUpInvalidEmail());

  static SignUpEmailValidationCubit get(context)=> BlocProvider.of(context); 

  void validateEmail (String email){
    Validation validation = Validation(email).required().email().validate(); 
    validation.isValid ? emit(SignUpValidEmail()) : emit(SignUpInvalidEmail()); 
  }
}
