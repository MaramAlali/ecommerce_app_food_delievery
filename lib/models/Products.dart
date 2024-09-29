// class ProductsModel {
//   ProductsModel({
//       required this.id,
//       required this.name,
//       required this.description,
//       required this.price,
//      required  this.stars,
//     required this.img,
//     required  this.location,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.typeId,});
//
//   ProductsModel.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     price = json['price'];
//     stars = json['stars'];
//     img = json['img'];
//     location = json['location'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     typeId = json['type_id'];
//   }
//   int? id;
//   String? name;
//   String? description;
//   int? price;
//   int? stars;
//   String? img;
//   String? location;
//   String? createdAt;
//   String? updatedAt;
//   int? typeId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['description'] = description;
//     map['price'] = price;
//     map['stars'] = stars;
//     map['img'] = img;
//     map['location'] = location;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     map['type_id'] = typeId;
//     return map;
//   }
//
// }