part of 'name_validation_cubit.dart';

@immutable
sealed class NameValidationState {}

final class NameValidationInitial extends NameValidationState {}
final class ValidName extends NameValidationState {}
final class InvalidName extends NameValidationState {}
