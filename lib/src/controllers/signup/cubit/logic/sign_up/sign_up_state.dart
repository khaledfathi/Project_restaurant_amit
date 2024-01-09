part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class Loading extends SignUpState {}
final class Success extends SignUpState {}
final class Fail extends SignUpState {}
final class NoInternet extends SignUpState {}
