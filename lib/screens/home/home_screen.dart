import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/screens/households/add_household_screen.dart';
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
  @override
  void initState() {
    super.initState();

    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    HouseholdDatabaseService.getCurrentUserHouseholds(householdNotifier);
    UserDatabaseService.getCurrentUser(userNotifier);
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1C3F37),
      appBar: AppBar(
        centerTitle: false,
        title: Text('Hello ${userNotifier.currentUser?.firstName}'),
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
      endDrawer: const CustomRightDrawer(),
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
