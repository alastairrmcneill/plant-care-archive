// Insert misc functions

// Water plant
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';

void waterPlant(PlantNotifier plantNotifier) {
  // Get new date
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);

  Timestamp nextWaterDate = Timestamp.fromDate(
    date.add(
      Duration(days: plantNotifier.currentPlant!.wateringFrequency),
    ),
  );

  Timestamp lastWateredDate = Timestamp.fromDate(date);

  Plant newPlant = plantNotifier.currentPlant!.copy(nextWaterDate: nextWaterDate, lastWateredDate: lastWateredDate);

  PlantDatabaseService.updatePlant(plantNotifier, newPlant);
}

// Undo watering plant
void revertWaterPlant() {}

deletePlant(UserNotifier userNotifier, HouseholdNotifier householdNotifier, PlantNotifier plantNotifier) async {
  Plant plant = plantNotifier.currentPlant!;

  // Delete Plant
  PlantDatabaseService.deletePlant(plantNotifier, plant);

  // Update notifiers
  HouseholdDatabaseService.getCurrentUserHouseholds(householdNotifier);
  PlantDatabaseService.getAllNotWateringTodayPlants(plantNotifier);
  PlantDatabaseService.getTodaysWateringPlants(plantNotifier);
}

updatePlant(UserNotifier userNotifier, HouseholdNotifier householdNotifier, PlantNotifier plantNotifier, Plant plant) async {
  Plant oldPlant = plantNotifier.currentPlant!;
  if (oldPlant.householdUID == plant.householdUID) {
    // staying in same house

    await PlantDatabaseService.updatePlant(plantNotifier, plant);
  } else {
    // moving house
    // remove from old house
    deletePlant(userNotifier, householdNotifier, plantNotifier);

    // Add to new house
    PlantDatabaseService.createPlant(plantNotifier, plant);
  }

  plantNotifier.setCurrentPlant = plant;
}
