import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/services/validation/validation.dart';

part 'email_validation_state.dart';

class EmailValidationCubit extends Cubit<EmailValidationState> {
  EmailValidationCubit() : super(InvalidEmail());

  static EmailValidationCubit get(context)=> BlocProvider.of(context); 

  void validateEmail (String email){
    Validation validation = Validation(email).required().email().validate(); 
    validation.isValid ? emit(ValidEmail()) : emit(InvalidEmail()); 
  }
}
