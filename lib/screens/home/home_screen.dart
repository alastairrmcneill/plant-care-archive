import 'dart:math';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: const Color(0xFF1C3F37),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add Plant');
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Column(
        children: [
          WaterTodayListView(),
          Expanded(
            child: PlantListView(),
          )
        ],
      ),
    );
  }
}
