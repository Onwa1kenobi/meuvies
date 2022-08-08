import 'package:meuvies/data/model/episode.dart';
import 'package:meuvies/data/model/image.dart';
import 'package:meuvies/data/model/schedule.dart';
import 'package:meuvies/util/extensions.dart';

class Show {
  int id;
  String url;
  String name;
  String? summary;
  List<String>? genres;
  Schedule? schedule;
  ImageData? image;
  List<Episode>? episodes;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.summary,
    required this.genres,
    required this.schedule,
    required this.image,
    required this.episodes,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      summary: json['summary'],
      genres: stringList(json['genres']),
      schedule: json['schedule'] != null
          ? Schedule.fromJson(Map<String, dynamic>.from(json['schedule']))
          : null,
      image: json['image'] != null
          ? ImageData.fromJson(Map<String, dynamic>.from(json['image']))
          : null,
      episodes: json['_embedded'] != null &&
              json['_embedded']['episodes'] != null
          ? (json['_embedded']['episodes'] as List)
              .map((data) => Episode.fromJson(Map<String, dynamic>.from(data)))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['name'] = name;
    data['summary'] = summary;
    data['genres'] = genres;
    data['schedule'] = schedule?.toJson();
    data['image'] = image?.toJson();
    return data;
  }
}
