import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  final String uid;
  final String name;
  final String? latinName;
  final String? pictureURL;
  final Timestamp lastWateredDate;
  final Timestamp nextWaterDate;
  final int wateringFrequency;
  final String? notes;
  final String room;

  Plant({
    required this.uid,
    required this.name,
    this.latinName,
    this.pictureURL,
    required this.lastWateredDate,
    required this.nextWaterDate,
    required this.wateringFrequency,
    this.notes,
    required this.room,
  });

  Plant copy({
    String? uid,
    String? name,
    String? latinName,
    String? pictureURL,
    Timestamp? lastWateredDate,
    Timestamp? nextWaterDate,
    int? wateringFrequency,
    String? notes,
    String? room,
  }) =>
      Plant(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        latinName: latinName ?? this.latinName,
        lastWateredDate: lastWateredDate ?? this.lastWateredDate,
        nextWaterDate: nextWaterDate ?? this.nextWaterDate,
        wateringFrequency: wateringFrequency ?? this.wateringFrequency,
        pictureURL: pictureURL ?? this.pictureURL,
        notes: notes ?? this.notes,
        room: room ?? this.room,
      );

  Map<String, Object?> toJSON() {
    return {
      'uid': uid,
      'name': name,
      'latinName': latinName,
      'pictureURL': pictureURL,
      'lastWateredDate': lastWateredDate,
      'nextWaterDate': nextWaterDate,
      'wateringFrequency': wateringFrequency,
      'notes': notes,
      'room': room,
    };
  }

  static Plant fromJSON(json) {
    return Plant(
      uid: json['uid'] as String,
      name: json['name'] as String,
      latinName: json['latinName'] as String?,
      lastWateredDate: json['lastWateredDate'] as Timestamp,
      nextWaterDate: json['nextWaterDate'] as Timestamp,
      wateringFrequency: json['wateringFrequency'] as int,
      pictureURL: json['pictureURL'] as String?,
      notes: json['notes'] as String?,
      room: json['room'] as String,
    );
  }
}
