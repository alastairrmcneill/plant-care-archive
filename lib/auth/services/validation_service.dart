import 'package:flutter/material.dart';

class Vaildator extends ChangeNotifier {
  bool _emailValid = false;
  bool _passwordValid = false;
  bool _firstNameValid = false;
  bool _lastNameValid = false;

  bool get emailStatus => _emailValid;
  bool get password1Status => _passwordValid;
  bool get firstNameStatus => _firstNameValid;
  bool get lastNameStatus => _lastNameValid;
  bool get loginStatus => _emailValid && _passwordValid;
  bool get registerStatus => _emailValid && _passwordValid && _firstNameValid && _lastNameValid;

  void validateFirstName(String firstName) {
    _firstNameValid = firstName.isNotEmpty;
    notifyListeners();
  }

  void validateLastName(String lastName) {
    _lastNameValid = lastName.isNotEmpty;
    notifyListeners();
  }

  void validateEmail(String email) {
    int atIndex = email.indexOf('@');
    int periodIndex = email.lastIndexOf('.');
    if (email.isEmpty || !email.contains('@') || atIndex < 1 || periodIndex <= atIndex + 1 || email.length == periodIndex + 1) {
      _emailValid = false;
    } else {
      _emailValid = true;
    }

    notifyListeners();
  }

  void validatePassword(String password1) {
    _passwordValid = password1.length > 5;
    notifyListeners();
  }

  void reset() {
    _emailValid = false;
    _passwordValid = false;
    _firstNameValid = false;
    _lastNameValid = false;
  }
}
