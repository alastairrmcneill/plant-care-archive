import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HouseholdPlants extends StatefulWidget {
  const HouseholdPlants({Key? key}) : super(key: key);

  @override
  _HouseholdPlantsState createState() => _HouseholdPlantsState();
}

class _HouseholdPlantsState extends State<HouseholdPlants> {
  @override
  void initState() {
    super.initState();

    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    HouseholdDatabaseService.getCurrentHouseholdPlants(householdNotifier);
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);

    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFECF1EA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: householdNotifier.householdPlants != null
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: ListView(
                children: householdNotifier.householdPlants!.map((plant) {
                  return PlantListTile(plant: plant);
                }).toList(),
              ),
            )
          : SizedBox(),
    );
  }
}
