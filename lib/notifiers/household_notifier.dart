import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';

class HouseholdNotifier extends ChangeNotifier {
  List<Household>? _userHouseholds;
  Household? _currentHousehold;
  List<Plant>? _householdPlants;
  List<AppUser>? _householdMembers;

  List<Household>? get userHouseholds => _userHouseholds;
  Household? get currentHousehold => _currentHousehold;
  List<Plant>? get householdPlants => _householdPlants;
  List<AppUser>? get householdMembers => _householdMembers;

  set setUserHouseholds(List<Household> userHouseholds) {
    _userHouseholds = userHouseholds;
    notifyListeners();
  }

  set setCurrentHousehold(Household currentHousehold) {
    _currentHousehold = currentHousehold;
    notifyListeners();
  }

  set setHouseholdPlants(List<Plant> householdPlants) {
    _householdPlants = householdPlants;
    notifyListeners();
  }

  set setHouseholdMembers(List<AppUser> householdMembers) {
    _householdMembers = householdMembers;
    notifyListeners();
  }
}
