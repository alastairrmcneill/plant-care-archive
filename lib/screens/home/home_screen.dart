import 'dart:math';
import 'package:flutter/material.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabBarViewController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabBarViewController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Hello ${AuthService.getCurrentUsername()}'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.signOut();
            },
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: const Icon(Icons.sort),
            ),
            iconSize: 24,
          ),
        ],
      ),
      body: Column(
        children: [
          WaterToday(),
          Expanded(
            child: PlantListView(),
          )
        ],
      ),
    );
  }
}
