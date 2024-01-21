part of 'favorites_ui_cubit.dart';

@immutable
sealed class FavoritesUiState {}

final class FavoritesUiInitial extends FavoritesUiState {}
final class FavoritesUiChanged extends FavoritesUiState {}
