import 'package:meuvies/data/model/image.dart';

class Episode {
  int id;
  String name;
  String? summary;
  int number;
  int season;
  ImageData? image;

  Episode({
    required this.id,
    required this.name,
    required this.summary,
    required this.number,
    required this.season,
    required this.image,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      summary: json['summary'],
      number: json['number'],
      season: json['season'],
      image: json['image'] != null
          ? ImageData.fromJson(Map<String, dynamic>.from(json['image']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['summary'] = summary;
    data['number'] = number;
    data['season'] = season;
    data['image'] = image?.toJson();
    return data;
  }
}
