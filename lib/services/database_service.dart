import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';

class UserDatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> createUserRecord(AppUser user) async {
    DocumentReference ref = _db.collection('Users').doc(user.uid);

    ref.set(user.toJSON());
  }

  static Future<DocumentSnapshot> readCurrentUser(String uid) async {
    DocumentReference ref = _db.collection('Users').doc(uid);

    return await ref.get();
  }
}

class PlantDatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<QuerySnapshot> getPlants(uid) async {
    QuerySnapshot result = await _db.collection('Users').doc(uid).collection('Plants').get();

    return result;
  }
}
