import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'product_on_category_favorites_state.dart';

class ProductOnCategoryFavoritesCubit extends Cubit<ProductOnCategoryFavoritesState> {
  ProductOnCategoryFavoritesCubit() : super(ProductOnCategoryFavoritesInitial());
  static ProductOnCategoryFavoritesCubit get(context) => BlocProvider.of(context);

  Future<bool> favoritesAction(String productId) async {
    //get all products marked as favorites
    List<String>? favorites =
        Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);

    // if it's first time to use favorites
    if (favorites == null) {
      await Globals.sharedPreferences.setStringList(PRODUCT_FAVORITES, []);
      favorites = Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);
    }
    //check action
    for (var inFavoriteId in favorites!) {
      if (inFavoriteId == productId) {
        favorites.removeWhere((element) => element == productId);
        await Globals.sharedPreferences.setStringList(PRODUCT_FAVORITES, favorites);
        emit(ProductOnCategoryFavoritesChanged());
        return true;
      }
    }
    favorites.add(productId);
    await Globals.sharedPreferences.setStringList(PRODUCT_FAVORITES, favorites);
    emit(ProductOnCategoryFavoritesChanged());
    return true;
  }
}
