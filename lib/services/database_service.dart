import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';
import 'package:provider/provider.dart';

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

  static Future<AppUser> getUser({required String userID}) async {
    DocumentReference ref = _db.collection('Users').doc(userID);

    DocumentSnapshot snapshot = await ref.get();
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    AppUser user = AppUser.fromJSON(data);
    return user;
  }

  static getCurrentUser(UserNotifier userNotifier) async {
    DocumentReference ref = _db.collection('Users').doc(AuthService.getCurrentUser());

    DocumentSnapshot snapshot = await ref.get();
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    AppUser user = AppUser.fromJSON(data);

    userNotifier.setCurrentUser = user;
  }

  static updateUser(UserNotifier userNotifier, AppUser user) async {
    DocumentReference ref = _db.collection('Users').doc(user.uid);

    await ref.set(user.toJSON()).whenComplete(() {
      userNotifier.setCurrentUser = user;
    });
  }
}

class PlantDatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create Plant

  static Future<bool> createPlant(PlantNotifier plantNotifier, Plant plant) async {
    bool success = false;
    DocumentReference ref = _db.collection('Households').doc(plant.householdUID).collection('Plants').doc();

    Plant newPlant = plant.copy(uid: ref.id);

    await ref.set(newPlant.toJSON()).whenComplete(() {
      getAllNotWateringTodayPlants(plantNotifier);
      getTodaysWateringPlants(plantNotifier);
    }).whenComplete(() {
      final DocumentReference docRef = _db.collection("Households").doc(plant.householdUID);
      docRef.update({"plantCount": FieldValue.increment(1)});
      success = true;
    }).onError((error, stackTrace) {
      success = false;
    });
    return success;
  }

  static getAllNotWateringTodayPlants(PlantNotifier plantNotifier) async {
    List<Plant> _plantList = [];

    // Find all households
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await _db.collection('Users').doc(AuthService.getCurrentUser()).get();

    Map<String, dynamic> data = docSnapshot.data()!;
    List<dynamic> householdsRaw = data['households'];
    List<String> households = List<String>.from(householdsRaw);

    // Loop thruogh households
    for (var household in households) {
      QuerySnapshot snapshot = await _db.collection('Households').doc(household).collection('Plants').where('nextWaterDate', isGreaterThan: Timestamp.now()).get();
      snapshot.docs.forEach((doc) {
        Plant plant = Plant.fromJSON(doc.data());
        _plantList.add(plant);
      });
    }

    plantNotifier.setNotWateringPlantList = _plantList;
  }

  static getTodaysWateringPlants(PlantNotifier plantNotifier) async {
    List<Plant> _plantList = [];

    // Find all households
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await _db.collection('Users').doc(AuthService.getCurrentUser()).get();

    Map<String, dynamic> data = docSnapshot.data()!;
    List<dynamic> householdsRaw = data['households'];
    List<String> households = List<String>.from(householdsRaw);

    // Loop thruogh households
    for (var household in households) {
      QuerySnapshot snapshot = await _db.collection('Households').doc(household).collection('Plants').where('nextWaterDate', isLessThan: Timestamp.now()).get();
      snapshot.docs.forEach((doc) {
        Plant plant = Plant.fromJSON(doc.data());
        _plantList.add(plant);
      });
    }

    plantNotifier.setWaterPlantList = _plantList;
  }

  static updatePlant(PlantNotifier plantNotifier, Plant plant) async {
    await _db.collection('Households').doc(plant.householdUID).collection('Plants').doc(plant.uid).update(plant.toJSON()).whenComplete(() {
      getAllNotWateringTodayPlants(plantNotifier);
      getTodaysWateringPlants(plantNotifier);
    });
  }
}

class HouseholdDatabaseService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  static Future<String> createHousehold(UserNotifier userNotifier, HouseholdNotifier householdNotifier, Household household) async {
    String returnString = '';
    DocumentReference ref = _db.collection('Households').doc();

    Household newHousehold = household.copy(uid: ref.id);

    await ref.set(newHousehold.toJSON()).whenComplete(() {
      getCurrentUserHouseholds(householdNotifier);
    }).whenComplete(() {
      returnString = ref.id;
    });
    return returnString;
  }

  // Read
  static Future<Household> getHouseholdFromCode(String code) async {
    Query query = _db.collection('Households').where('code', isEqualTo: code);
    QuerySnapshot querySnapshot = await query.get();

    List<Household> householdList = querySnapshot.docs.map((doc) => Household.fromJSON(doc)).toList();

    return householdList[0];
  }

  static getCurrentUserHouseholds(HouseholdNotifier householdNotifier) async {
    // Find all households
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await _db.collection('Users').doc(AuthService.getCurrentUser()).get();

    Map<String, dynamic> data = docSnapshot.data()!;
    List<dynamic> householdsRaw = data['households'];
    List<String> householdIDs = List<String>.from(householdsRaw);

    // Get households
    List<Household> _householdList = [];

    for (var householdID in householdIDs) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection('Households').doc(householdID).get();
      Map<String, dynamic>? json = snapshot.data();

      _householdList.add(Household.fromJSON(json));
    }

    householdNotifier.setUserHouseholds = _householdList;
  }

  static getCurrentHouseholdPlants(HouseholdNotifier householdNotifier) async {
    CollectionReference ref = _db.collection('Households').doc(householdNotifier.currentHousehold!.uid).collection('Plants');

    QuerySnapshot querySnapshot = await ref.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<Plant> _plantList = [];
    allData.forEach((data) {
      Plant plant = Plant.fromJSON(data);
      _plantList.add(plant);
    });

    householdNotifier.setHouseholdPlants = _plantList;
  }

  static getCurrentHouseholdMembers(HouseholdNotifier householdNotifier) async {}

  // Update

  static updateHousehold(HouseholdNotifier householdNotifier, Household household) async {
    DocumentReference ref = _db.collection('Households').doc(household.uid);

    ref.set(household.toJSON()).whenComplete(() {
      getCurrentUserHouseholds(householdNotifier);
    });
  }
}
