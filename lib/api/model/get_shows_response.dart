import 'package:meuvies/data/model/show.dart';

class GetShowsResponse {
  List<Show> shows;

  GetShowsResponse({
    required this.shows,
  });

  factory GetShowsResponse.fromJson(List<dynamic> json) {
    return GetShowsResponse(
      shows: json.map((data) => Show.fromJson(data)).toList(),
    );
  }

  List<dynamic> toJson() {
    final List<dynamic> data = shows.map((data) => data.toJson()).toList();
    return data;
  }
}
