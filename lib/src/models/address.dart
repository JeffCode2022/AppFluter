import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.id,
    this.idUser,
    this.address,
    this.neighborhood,
    this.lat,
    this.lng,
  });

  String? id;
  String? idUser;
  String? address;
  String? neighborhood;
  double? lat;
  double? lng;
   List<Address> toList = [];

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"] is int ? json['id'].toString() : json['id'],
        idUser: json["id_user"],
        address: json["address"],
        neighborhood: json["neighborhood"],
        lat: json["lat"] is String ? double.parse(json["lat"]) : json["lat"],
        lng: json["lng"] is String ? double.parse(json["lng"]) : json["lng"],
      );

void fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final address = Address.fromJson(item);
      toList.add(address);
        // ignore: avoid_print
        print(address);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "address": address,
        "neighborhood": neighborhood,
        "lat": lat,
        "lng": lng,
      };
}
