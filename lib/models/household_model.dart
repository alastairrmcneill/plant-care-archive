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
  static Household fromJSON(json) {
    List<dynamic> members = json['members'];
    List<String> newMembers = List<String>.from(members);

    return Household(
      uid: json['uid'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      members: newMembers,
    );
  }

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
