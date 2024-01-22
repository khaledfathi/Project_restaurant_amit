import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'sign_up_name_validation_state.dart';

//validate name string in sign up screen
class SignUpNameValidationCubit extends Cubit<SignUpNameValidationState> {
  SignUpNameValidationCubit() : super(SignUpInvalidName());

  static SignUpNameValidationCubit get(context)=> BlocProvider.of(context); 
  
  void validateName(String name){
    Validation validation = Validation(name ).required().length(minLength: 3).validate();
    validation.isValid ? emit(SignUpValidName()) : emit(SignUpInvalidName());
  }
}
