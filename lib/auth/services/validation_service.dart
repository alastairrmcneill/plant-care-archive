import 'package:flutter/material.dart';

class Vaildator extends ChangeNotifier {
  bool _emailValid = false;
  bool _passwordValid = false;
  bool _formValid = false;

  bool get emailStatus => _emailValid;
  bool get passwordStatus => _passwordValid;
  bool get formStatus => _emailValid && _passwordValid;

  void validateEmail(String email) {
    _emailValid = email.length > 5;
    notifyListeners();
  }

  void validatePassword(String password) {
    _passwordValid = password.length > 5;
    notifyListeners();
  }

  void validateForm() {
    _formValid = _emailValid && _passwordValid;
    notifyListeners();
  }

  void reset() {
    _emailValid = false;
    _passwordValid = false;
    _formValid = false;
  }
}
