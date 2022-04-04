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

  // Create Plant

  static Future<bool> createPlant(PlantNotifier plantNotifier, Plant plant) async {
    bool success = false;
    DocumentReference ref = _db.collection('Users').doc(AuthService.getCurrentUser()).collection('Plants').doc();

    Plant newPlant = plant.copy(uid: ref.id);

    await ref.set(newPlant.toJSON()).whenComplete(() {
      getAllNotWateringTodayPlants(plantNotifier);
      getTodaysWateringPlants(plantNotifier);
    }).whenComplete(() {
      success = true;
    }).onError((error, stackTrace) {
      success = false;
    });
    return success;
  }

  // static getAllPlants(PlantNotifier plantNotifier) async {
  //   QuerySnapshot snapshot = await _db.collection('Users').doc(AuthService.getCurrentUser()).collection('Plants').get();

  //   List<Plant> _plantList = [];

  //   snapshot.docs.forEach((doc) {
  //     Plant plant = Plant.fromJSON(doc.data());
  //     _plantList.add(plant);
  //   });
  //   plantNotifier.setPlantList = _plantList + _plantList + _plantList + _plantList + _plantList + _plantList;
  // }

  static getAllNotWateringTodayPlants(PlantNotifier plantNotifier) async {
    QuerySnapshot snapshot = await _db.collection('Users').doc(AuthService.getCurrentUser()).collection('Plants').where('nextWaterDate', isGreaterThan: Timestamp.now()).get();

    List<Plant> _plantList = [];

    snapshot.docs.forEach((doc) {
      Plant plant = Plant.fromJSON(doc.data());
      _plantList.add(plant);
    });
    plantNotifier.setNotWateringPlantList = _plantList;
  }

  static getTodaysWateringPlants(PlantNotifier plantNotifier) async {
    QuerySnapshot snapshot = await _db.collection('Users').doc(AuthService.getCurrentUser()).collection('Plants').where('nextWaterDate', isLessThan: Timestamp.now()).get();

    List<Plant> _plantList = [];
    snapshot.docs.forEach((doc) {
      Plant plant = Plant.fromJSON(doc.data());
      _plantList.add(plant);
    });
    plantNotifier.setWaterPlantList = _plantList;
  }

  static updatePlant(PlantNotifier plantNotifier, Plant plant) async {
    await _db.collection('Users').doc(AuthService.getCurrentUser()).collection('Plants').doc(plant.uid).update(plant.toJSON()).whenComplete(() {
      getAllNotWateringTodayPlants(plantNotifier);
      getTodaysWateringPlants(plantNotifier);
    });
  }
}
