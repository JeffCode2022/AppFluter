import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {

  String? id;
  String? name;
  String? description;
  List<Category> toList = [];

  Category({
    this.id,
    this.name,
    this.description,
  });



  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] is int ? json["id"].toString() : json['id'],
    name: json["name"],
    description: json["description"],
  );

void fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final category = Category.fromJson(item);
      toList.add(category);
        // ignore: avoid_print
        print(category);
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
