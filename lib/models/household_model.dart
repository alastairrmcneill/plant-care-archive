import 'package:plant_care/models/models.dart';

class Household {
  final String uid;
  final String name;
  final List<String> members;
  final List<Plant> plants;

  Household({
    required this.uid,
    required this.name,
    required this.members,
    required this.plants,
  });
}
