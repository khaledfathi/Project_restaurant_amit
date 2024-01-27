part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}
final class CheckOutLoading extends CheckoutState {}
final class CheckOutSuccuess extends CheckoutState {}
final class CheckOutFail extends CheckoutState {}
