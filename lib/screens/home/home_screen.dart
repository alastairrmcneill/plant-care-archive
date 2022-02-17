import 'package:flutter/material.dart';
import 'package:plant_care/services/services.dart';

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
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
