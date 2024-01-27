part of 'sign_up_password_visibility_cubit.dart';

@immutable
sealed class SignUpPasswordVisibilityState {}

final class SignUpPasswordVisibilityInitial extends SignUpPasswordVisibilityState {}
final class SignUpShowPassword extends SignUpPasswordVisibilityState {}
final class SignUpHidePassword extends SignUpPasswordVisibilityState {}
