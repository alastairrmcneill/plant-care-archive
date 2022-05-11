import 'package:flutter/material.dart';
import 'package:plant_care/models/household_model.dart';

class HouseholdNotifier extends ChangeNotifier {
  List<Household>? _userHouseholds;
  Household? _currentHousehold;

  List<Household>? get userHouseholds => _userHouseholds;
  Household? get currentHousehold => _currentHousehold;

  set setUserHouseholds(List<Household> userHouseholds) {
    _userHouseholds = userHouseholds;
    notifyListeners();
  }

  set setCurrentHousehold(Household currentHousehold) {
    _currentHousehold = currentHousehold;
    notifyListeners();
  }
}
