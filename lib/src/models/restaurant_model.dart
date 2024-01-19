class RestaurantModel {
  String? id ;
  String? categoryId ;
  String? categoryName ; 
  String? name ; 
  String? address ; 
  String? phone; 
  String? lat ; 
  String? long ; 
  String? image ; 
  RestaurantModel ({
    this.id,
    this.categoryId,
    this.categoryName,
    this.name,
    this.address,
    this.phone,
    this.lat,
    this.long,
    this.image
  }); 
  
  RestaurantModel.fromMap (Map restaurantFiled){
    id = restaurantFiled['id'];
    categoryId = restaurantFiled['category_id'];
    categoryName = restaurantFiled['category_name'];
    name = restaurantFiled['name'];
    address = restaurantFiled['address'];
    phone = restaurantFiled['phone'];
    lat = restaurantFiled['lat'];
    long = restaurantFiled['long'];
    image = restaurantFiled['image'];
  }
}