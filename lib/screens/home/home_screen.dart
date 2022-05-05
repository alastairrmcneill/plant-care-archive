import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/screens/home/add_household_screen.dart';
import 'package:plant_care/screens/screens.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.home),
            label: 'Household',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddHousehold())),
          ),
          SpeedDialChild(
            child: const Icon(FontAwesomeIcons.seedling),
            label: 'Plant',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPlant())),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          WaterTodayListView(),
          Expanded(
            child: PlantListView(),
          )
        ],
      ),
    );
  }
}
