import 'package:plant_care/models/models.dart';

class Household {
  final String? uid;
  final String name;
  final String code;
  final List<String> members;

  Household({
    this.uid = '',
    required this.name,
    required this.code,
    required this.members,
  });

  // From JSON

  // To JSON
  Map<String, Object> toJSON() {
    return {
      'uid': uid!,
      'name': name,
      'code': code,
      'members': members,
    };
  }

  Household copy({
    String? uid,
    String? name,
    String? code,
    List<String>? members,
  }) =>
      Household(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        code: code ?? this.code,
        members: members ?? this.members,
      );
}
