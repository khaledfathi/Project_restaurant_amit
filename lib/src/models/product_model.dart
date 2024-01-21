class ProductModel {
  int? id ;
  String? productCategoryId; 
  String? productCategoryName; 
  String? restaurantId; 
  String? restaurantName; 
  String? name; 
  String? quantity; 
  String? discount; 
  String? price; 
  String? image; 

  ProductModel({
    this.id,
    this.productCategoryId, 
    this.productCategoryName,
    this.restaurantId,
    this.restaurantName,
    this.name,
    this.quantity,
    this.discount,
    this.price,
    this.image
  });

  ProductModel.fromMap (Map data){
    id = data['id'];
    productCategoryId = data['product_category_id'];
    productCategoryName = data['product_category_name'];
    restaurantId = data['restaurant_id'];
    restaurantName = data['restaurant_name'];
    name = data['name'];
    quantity = data['quantity'];
    discount = data['discount'];
    price = data['price'];
    image = data['image'];
  }
}