part of 'sign_up_name_validation_cubit.dart';

@immutable
sealed class SignUpNameValidationState {}

final class SignUpNameValidationInitial extends SignUpNameValidationState {}
final class SignUpValidName extends SignUpNameValidationState {}
final class SignUpInvalidName extends SignUpNameValidationState {}
