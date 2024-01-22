part of 'sign_up_email_validation_cubit.dart';

@immutable
sealed class SignUpEmailValidationState {}

final class SignUpEmailValidationInitial extends SignUpEmailValidationState {}
final class SignUpValidEmail extends SignUpEmailValidationState {}
final class SignUpInvalidEmail extends SignUpEmailValidationState {}
