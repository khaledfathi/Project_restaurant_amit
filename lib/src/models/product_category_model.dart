class ProductCategoryModel {
  int? id; 
  String? name; 
  String? image; 
  ProductCategoryModel({
    this.id,
    this.name,
    this.image,
  });
  ProductCategoryModel.fromMap(Map data){
    id = data['id'];
    name = data['name'];
    image = data['image'];
  }
}