import 'package:project_restaurant/src/models/user_model.dart';

class Auth {
  static UserModel? currentUser ; 
  
  static setCurrentUser (UserModel user){
    currentUser = user; 
  }
}