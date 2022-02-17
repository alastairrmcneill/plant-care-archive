import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/models/user_model.dart';
import 'package:plant_care/services/auth_service.dart';
import 'package:plant_care/services/validation_service.dart';
import 'package:plant_care/support/theme_data.dart';
import 'package:plant_care/support/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser?>.value(
          value: AuthService().appUserStream,
          initialData: null,
        ),
        ChangeNotifierProvider<Vaildator>(
          create: (_) => Vaildator(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.getTheme(),
        home: Wrapper(),
      ),
    );
  }
}
