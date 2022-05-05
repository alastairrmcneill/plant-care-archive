import 'dart:math';

import 'package:plant_care/models/models.dart';

import 'services.dart';

Future<String> createHousehold(String name) async {
  // Get current User ID
  String userID = AuthService.getCurrentUser();

  // Create household
  String code = randomString(6);
  Household household = Household(name: name, code: code, members: [userID]);
  String householdID = await HouseholdDatabaseService.createHousehold(household);

  // Update user
  AppUser user = await UserDatabaseService.getUser(userID: userID);
  user.households.add(householdID);
  await UserDatabaseService.updateUser(user);

  return code;
}

Future<String> addHousehold(String code) async {
  // Get current User ID
  String userID = AuthService.getCurrentUser();

  // Get household
  Household household = await HouseholdDatabaseService.getHouseholdFromCode(code);

  // Update user
  AppUser user = await UserDatabaseService.getUser(userID: userID);
  user.households.add(household.uid!);
  await UserDatabaseService.updateUser(user);

  // Update household
  household.members.add(userID);
  await HouseholdDatabaseService.updateHousehold(household);

  return household.name;
}

String randomString(int length) {
  const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random r = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
}
