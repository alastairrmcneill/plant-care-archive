import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:plant_care/models/plant_model.dart';

class PlantNotifier extends ChangeNotifier {
  List<Plant>? _plantList = null;
  Plant? _currentPlant = null;

  List<Plant>? get plantList => _plantList;
  Plant? get currentPlant => _currentPlant;

  set setPlantList(List<Plant> plantList) {
    _plantList = plantList;
    notifyListeners();
  }

  set setCurrentPlant(Plant currentPlant) {
    _currentPlant = currentPlant;
    notifyListeners();
  }
}
