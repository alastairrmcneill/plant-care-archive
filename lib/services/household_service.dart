import 'dart:math';

import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';

import 'services.dart';

Future<String> createHousehold(UserNotifier userNotifier, HouseholdNotifier householdNotifier, String name) async {
  // Get current User ID
  String userID = AuthService.getCurrentUser();

  // Create household
  String code = randomString(6);
  Household household = Household(name: name, code: code, members: [userID]);
  String householdID = await HouseholdDatabaseService.createHousehold(userNotifier, householdNotifier, household);

  // Update user
  AppUser user = await UserDatabaseService.getUser(userID: userID);
  user.households.add(householdID);
  await UserDatabaseService.updateUser(userNotifier, user);

  return code;
}

Future<String> addHousehold(UserNotifier userNotifier, HouseholdNotifier householdNotifier, String code) async {
  // Get current User ID
  String userID = AuthService.getCurrentUser();

  // Get household
  Household household = await HouseholdDatabaseService.getHouseholdFromCode(code);

  // Update user
  AppUser user = await UserDatabaseService.getUser(userID: userID);
  user.households.add(household.uid!);
  await UserDatabaseService.updateUser(userNotifier, user);

  // Update household
  household.members.add(userID);
  household.memberCount++;
  await HouseholdDatabaseService.updateHousehold(householdNotifier, household);

  return household.name;
}

updateHousehold(UserNotifier userNotifier, HouseholdNotifier householdNotifier, String name) async {
  Household newHousehold = householdNotifier.currentHousehold!.copy(name: name);
  HouseholdDatabaseService.updateHousehold(householdNotifier, newHousehold);
  householdNotifier.setCurrentHousehold = newHousehold;
}

leaveHousehold(UserNotifier userNotifier, HouseholdNotifier householdNotifier, PlantNotifier plantNotifier) async {
  AppUser appUser = userNotifier.currentUser!;
  Household household = householdNotifier.currentHousehold!;

// Remove member from household
  household.members.remove(appUser.uid);

// Update member count
  household.memberCount -= 1;

  // Update household
  HouseholdDatabaseService.updateHousehold(householdNotifier, household);

// remove household from AppUser
  appUser.households.remove(household.uid);

  UserDatabaseService.updateUser(userNotifier, appUser);

  HouseholdDatabaseService.getCurrentUserHouseholds(householdNotifier);

  PlantDatabaseService.getAllNotWateringTodayPlants(plantNotifier);
  PlantDatabaseService.getTodaysWateringPlants(plantNotifier);
}

String randomString(int length) {
  const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random r = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
}
