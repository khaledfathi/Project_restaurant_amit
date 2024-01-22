import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'favorites_remove_state.dart';

///Remove Single element from Favorites on sharedprefrence String List on key [PRODUCT_FAVORITES];
class FavoritesRemoveCubit extends Cubit<FavoritesRemoveState> {
  FavoritesRemoveCubit() : super(FavoritesRemoveInitial());
  static FavoritesRemoveCubit get(context) => BlocProvider.of(context);

  Future<bool> removeFromFavorites(String productId) async {
    //get all products marked as favorites
    List<String>? favorites =
        Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);

    //check action
    for (var inFavoriteId in favorites!) {
      if (inFavoriteId == productId) {
        favorites.removeWhere((element) => element == productId);
        await Globals.sharedPreferences
            .setStringList(PRODUCT_FAVORITES, favorites);
        emit(FavoritesRemoveChanged());
        return true;
      }
    }
    return false;
  }

}
