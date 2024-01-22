part of 'product_on_category_favorites_cubit.dart';

@immutable
sealed class ProductOnCategoryFavoritesState {}

final class ProductOnCategoryFavoritesInitial extends ProductOnCategoryFavoritesState {}
final class ProductOnCategoryFavoritesChanged extends ProductOnCategoryFavoritesState {}
