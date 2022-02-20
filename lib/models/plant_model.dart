import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  final String uid;
  final String name;
  final String? pictureURL;
  final Timestamp dateLastWatered;
  final int wateringFrequency;
  final String? notes;

  Plant({
    required this.uid,
    required this.name,
    this.pictureURL,
    required this.dateLastWatered,
    required this.wateringFrequency,
    this.notes,
  });

  Plant copy({
    String? uid,
    String? name,
    String? pictureURL,
    Timestamp? dateLastWatered,
    int? wateringFrequency,
    String? notes,
  }) =>
      Plant(
          uid: uid ?? this.uid,
          name: name ?? this.name,
          dateLastWatered: dateLastWatered ?? this.dateLastWatered,
          wateringFrequency: wateringFrequency ?? this.wateringFrequency,
          pictureURL: pictureURL ?? this.pictureURL,
          notes: notes ?? this.notes);

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'pictureURL': pictureURL,
      'dateLastWatered': dateLastWatered,
      'wateringFrequency': wateringFrequency,
      'notes': notes,
    };
  }

  static Plant fromJSON(json) {
    return Plant(
      uid: json['uid'] as String,
      name: json['name'] as String,
      dateLastWatered: json['dateLastWatered'] as Timestamp,
      wateringFrequency: json['wateringFrequency'] as int,
      pictureURL: json['pictureURL'] as String?,
      notes: json['notes'] as String?,
    );
  }
}
