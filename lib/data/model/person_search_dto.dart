import 'package:meuvies/data/model/person.dart';

class PersonSearchDTO {
  Person person;

  PersonSearchDTO({
    required this.person,
  });

  factory PersonSearchDTO.fromJson(Map<String, dynamic> json) {
    return PersonSearchDTO(
      person: Person.fromJson(Map<String, dynamic>.from(json['person'])),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['person'] = person.toJson();
    return data;
  }
}
