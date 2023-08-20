import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BeeModel {
  final String id;
  final String name;
  final String lat;
  final String lng;
  BeeModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }

  factory BeeModel.fromMap(Map<String, dynamic> map) {
    return BeeModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      lat: (map['lat'] ?? '') as String,
      lng: (map['lng'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BeeModel.fromJson(String source) => BeeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
