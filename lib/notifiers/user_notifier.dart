import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';

class UserNotifier extends ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  set setCurrentUser(AppUser currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
}
