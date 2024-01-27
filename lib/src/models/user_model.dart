class UserModel {
  int? id ;
  String? name ;
  String? email ;
  String? image ; 
  String? token ; 
  UserModel ({this.name , this.email, this.image , this.token}); 
  
  UserModel.fromMap (Map userFields){
    id = userFields['id'];
    name = userFields['name'];
    email = userFields['email'];
    image = userFields['image']; 
    token = userFields['token'];
  }
}