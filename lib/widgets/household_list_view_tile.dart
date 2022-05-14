import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/household_notifier.dart';
import 'package:plant_care/screens/households/household_detail_screen.dart';
import 'package:provider/provider.dart';

class HouseholdTile extends StatelessWidget {
  final Household household;
  const HouseholdTile({Key? key, required this.household}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    return Container(
      height: 100,
      color: Colors.blue,
      child: GestureDetector(
        onTap: () {
          householdNotifier.setCurrentHousehold = household;
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdDetail()));
        },
        child: Text(household.name),
      ),
    );
  }
}
