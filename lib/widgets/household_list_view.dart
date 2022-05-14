import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/database_service.dart';
import 'package:plant_care/widgets/household_list_view_tile.dart';
import 'package:provider/provider.dart';

class HouseholdListView extends StatefulWidget {
  const HouseholdListView({Key? key}) : super(key: key);

  @override
  State<HouseholdListView> createState() => _HouseholdListViewState();
}

class _HouseholdListViewState extends State<HouseholdListView> {
  @override
  void initState() {
    super.initState();

    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    refresh(householdNotifier);
  }

  Future<void> refresh(HouseholdNotifier householdNotifier) async {
    await HouseholdDatabaseService.getCurrentUserHouseholds(householdNotifier);
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    return RefreshIndicator(
      onRefresh: () => refresh(householdNotifier),
      child: ListView(
        children: householdNotifier.userHouseholds!.map((household) {
          return HouseholdTile(household: household);
        }).toList(),
      ),
    );
  }
}
