import 'dart:math';

import 'package:plant_care/models/models.dart';

import 'services.dart';

Future<void> createHousehold(String name) async {
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
}

String randomString(int length) {
  const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  Random r = Random();
  return String.fromCharCodes(Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
}
