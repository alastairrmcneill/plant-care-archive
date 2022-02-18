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
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Plant Care',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              dynamic result = await AuthService.signOut();
            },
            icon: Icon(Icons.logout_outlined),
            iconSize: 24,
          ),
        ],
      ),
      // bottomNavigationBar: ,
    );
  }
}
