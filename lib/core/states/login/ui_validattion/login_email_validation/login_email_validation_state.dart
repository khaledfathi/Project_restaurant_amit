part of 'login_email_validation_cubit.dart';

@immutable
sealed class LoginEmailValidationState {}

final class LoginEmailValidationInitial extends LoginEmailValidationState {}
final class LoginInvalidEmail extends LoginEmailValidationState {}
final class LoginValidEmail extends LoginEmailValidationState {}
