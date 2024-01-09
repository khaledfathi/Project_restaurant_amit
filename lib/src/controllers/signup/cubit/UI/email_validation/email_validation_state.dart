part of 'email_validation_cubit.dart';

@immutable
sealed class EmailValidationState {}

final class EmailValidationInitial extends EmailValidationState {}
final class ValidEmail extends EmailValidationState {}
final class InvalidEmail extends EmailValidationState {}
