part of 'restaurants_cubit.dart';

@immutable
sealed class RestaurantsState {}

final class RestaurantsInitial extends RestaurantsState {}
final class RestaurantsLoading extends RestaurantsState {}
final class RestaurantsSuccess extends RestaurantsState {}
final class RestaurantsFail extends RestaurantsState {}
final class RestaurantsNoInternet extends RestaurantsState {}
final class RestaurantsConnectionError extends RestaurantsState {}
