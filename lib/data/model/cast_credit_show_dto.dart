import 'package:meuvies/data/model/show.dart';

class CastCreditShowDTO {
  Show show;

  CastCreditShowDTO({
    required this.show,
  });

  factory CastCreditShowDTO.fromJson(Map<String, dynamic> json) {
    return CastCreditShowDTO(
      show: Show.fromJson(Map<String, dynamic>.from(json['_embedded']['show'])),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['show'] = show.toJson();
    return data;
  }
}
