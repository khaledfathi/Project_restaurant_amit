import 'package:project_restaurant/core/core_export.dart';

class HomeController {
    Future<List> restaurantsData ()async{
      int categoriesCount = 0 ; 
      List data = [] ; 
      await Globals.api.get(API_GET_RESTAURANT_CATEGORIES).then((response){
        if (response.statusCode == 200 ) {
          categoriesCount  = response.data.length; 
        }
      });
     for (var i = 1; i <= categoriesCount ; i++) {
      await Globals.api.get('$API_GET_RESTAURANT_FILTER_BY_CATEGORY/$i').then((response){
        data.add(response.data);
      }); 
     }
     return data ;  
    }
}