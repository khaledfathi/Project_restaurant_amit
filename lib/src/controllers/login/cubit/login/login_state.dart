part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {}
final class LoginFail extends LoginState {}
final class LoginConnectionError extends LoginState {}
final class LoginNoInternet extends LoginState {}
