import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'name_validation_state.dart';

class NameValidationCubit extends Cubit<NameValidationState> {
  NameValidationCubit() : super(InvalidName());

  static NameValidationCubit get(context)=> BlocProvider.of(context); 
  
  void validateName(String name){
    Validation validation = Validation(name ).required().length(minLength: 3).validate();
    validation.isValid ? emit(ValidName()) : emit(InvalidName());
  }
}
