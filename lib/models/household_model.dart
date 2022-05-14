import 'package:plant_care/models/models.dart';

class Household {
  final String? uid;
  final String name;
  final String code;
  late int memberCount;
  final int plantCount;
  final List<String> members;

  Household({
    this.uid = '',
    required this.name,
    required this.code,
    required this.members,
    this.memberCount = 1,
    this.plantCount = 0,
  });

  // From JSON
  static Household fromJSON(json) {
    List<dynamic> members = json['members'];
    List<String> newMembers = List<String>.from(members);

    return Household(
      uid: json['uid'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      memberCount: json['memberCount'] as int,
      plantCount: json['plantCount'] as int,
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
      'plantCount': plantCount,
      'memberCount': memberCount,
    };
  }

  Household copy({
    String? uid,
    String? name,
    String? code,
    int? memberCount,
    int? plantCount,
    List<String>? members,
  }) =>
      Household(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        code: code ?? this.code,
        memberCount: memberCount ?? this.memberCount,
        plantCount: plantCount ?? this.plantCount,
        members: members ?? this.members,
      );
}
