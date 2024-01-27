part of 'favorites_remove_cubit.dart';

@immutable
sealed class FavoritesRemoveState {}

final class FavoritesRemoveInitial extends FavoritesRemoveState {}
final class FavoritesRemoveChanged extends FavoritesRemoveState {}
