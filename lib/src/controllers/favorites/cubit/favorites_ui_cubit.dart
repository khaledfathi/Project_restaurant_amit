import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_restaurant/core/core_export.dart';

part 'favorites_ui_state.dart';

class FavoritesUiCubit extends Cubit<FavoritesUiState> {
  FavoritesUiCubit() : super(FavoritesUiInitial());
  static FavoritesUiCubit get(context) => BlocProvider.of(context);

  Future<bool> removeFromFavorites (String productId)async{
        //get all products marked as favorites
    List<String>? favorites =
        Globals.sharedPreferences.getStringList(PRODUCT_FAVORITES);

    //check action
    for (var inFavoriteId in favorites!) {
      if (inFavoriteId == productId) {
        favorites.removeWhere((element) => element == productId);
        await Globals.sharedPreferences.setStringList(PRODUCT_FAVORITES, favorites);
        emit(FavoritesUiChanged());
        return true;
      }
    }
    return false ; 
  }

  void AddProductToCart (String productId){
    //add to cart then emit 
  }
}