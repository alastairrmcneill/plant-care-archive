import 'package:flutter/material.dart';
import 'package:plant_care/models/plant_model.dart';

class PlantNotifier extends ChangeNotifier {
  List<Plant>? _notWateringPlantList;
  List<Plant>? _waterPlantList;
  Plant? _currentPlant;

  List<Plant>? get notWateringPlantList => _notWateringPlantList;
  List<Plant>? get waterPlantList => _waterPlantList;
  Plant? get currentPlant => _currentPlant;

  set setNotWateringPlantList(List<Plant> notWateringPlantList) {
    _notWateringPlantList = notWateringPlantList;
    notifyListeners();
  }

  set setWaterPlantList(List<Plant> waterPlantList) {
    _waterPlantList = waterPlantList;
    notifyListeners();
  }

  set setCurrentPlant(Plant currentPlant) {
    _currentPlant = currentPlant;
    notifyListeners();
  }
}
