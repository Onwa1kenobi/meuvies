import 'package:meuvies/data/model/image.dart';

class Person {
  int id;
  String name;
  ImageData? image;

  Person({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      image: json['image'] != null
          ? ImageData.fromJson(Map<String, dynamic>.from(json['image']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image?.toJson();
    return data;
  }
}