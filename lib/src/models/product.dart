// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String? name;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  double? price;
  int? idCategory;
  int? quantity;
  List<Product> toList = [];

  Product({
    this.id,
    this.name,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.price,
    this.idCategory,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        price: json['price'] is String
            ? double.parse(json['price'])
            : isInteger(json['price'])
                ? json["price"].toDouble()
                : json['price'],
        idCategory: json["id_category"] is String
            ? int.parse(json["id_category"])
            : json["id_category"] is int
                ? json["id_category"]
                : null,
        quantity: json["quantity"],
      );

<<<<<<< HEAD
// Static method to convert a list of JSON objects to a list of Products
  static List<Product> fromJsonList(dynamic jsonList) {
    if (jsonList is List) {
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      return [];
    }
=======
  Product.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;
    // ignore: avoid_function_literals_in_foreach_calls
    jsonList.forEach((item) {
      Product product = Product.fromJson(item);
      toList.add(product);
    });
>>>>>>> 661796690c90e1578bea351876b3a6728de9d4db
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "price": price,
        "id_category": idCategory,
        "quantity": quantity,
      };

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
}
