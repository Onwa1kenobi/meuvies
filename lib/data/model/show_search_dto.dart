import 'package:meuvies/data/model/show.dart';

class ShowSearchDTO {
  Show show;

  ShowSearchDTO({
    required this.show,
  });

  factory ShowSearchDTO.fromJson(Map<String, dynamic> json) {
    return ShowSearchDTO(
      show: Show.fromJson(Map<String, dynamic>.from(json['show'])),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['show'] = show.toJson();
    return data;
  }
}
