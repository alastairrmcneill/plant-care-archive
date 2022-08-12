import 'package:firebase_core/firebase_core.dart';
import 'package:plant_care/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(flavor: 'Production'));
}
