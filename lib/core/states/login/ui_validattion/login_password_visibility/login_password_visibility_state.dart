part of 'login_password_visibility_cubit.dart';

@immutable
sealed class LoginPasswordVisibilityState {}

final class LoginPasswordVisibilityInitial extends LoginPasswordVisibilityState {}
final class LoginShowPassword extends LoginPasswordVisibilityState {}
final class LoginHidePassword extends LoginPasswordVisibilityState {}
