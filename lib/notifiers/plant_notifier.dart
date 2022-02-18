import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:plant_care/models/plant_model.dart';

class PlantNotifier extends ChangeNotifier {
  List<Plant> _plantList = [];
  Plant _currentPlant = Plant();

  UnmodifiableListView<Plant> get getPlantList => UnmodifiableListView(_plantList);
  Plant get getCurrentPlant => _currentPlant;

  set setPlantList(List<Plant> plantList) {
    _plantList = plantList;
    notifyListeners();
  }

  set setCurrentPlant(Plant currentPlant) {
    _currentPlant = currentPlant;
    notifyListeners();
  }
}
