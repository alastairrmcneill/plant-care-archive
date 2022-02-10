import 'package:flutter/material.dart';
import 'package:plant_care/auth/services/auth_service.dart';
import 'package:plant_care/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            dynamic result = await AuthService.signOut();
            if (result == null) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreen()));
            }
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
