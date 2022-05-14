import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/household_notifier.dart';
import 'package:provider/provider.dart';

class HouseholdDetail extends StatefulWidget {
  const HouseholdDetail({Key? key}) : super(key: key);

  @override
  State<HouseholdDetail> createState() => _HouseholdDetailState();
}

class _HouseholdDetailState extends State<HouseholdDetail> {
  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    Household household = householdNotifier.currentHousehold!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print('share');
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () {
              print('share');
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        children: [
          Text(household.name),
        ],
      ),
    );
  }
}


///What to show 
///Name, code, share button 
///People
///Plants
///