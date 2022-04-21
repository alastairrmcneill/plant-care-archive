import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlantListView extends StatefulWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  _PlantListViewState createState() => _PlantListViewState();
}

class _PlantListViewState extends State<PlantListView> {
  @override
  void initState() {
    super.initState();

    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    PlantDatabaseService.getAllNotWateringTodayPlants(plantNotifier);
  }

  Future<void> refresh(PlantNotifier plantNotifier) async {
    PlantDatabaseService.getAllNotWateringTodayPlants(plantNotifier);
    PlantDatabaseService.getTodaysWateringPlants(plantNotifier);
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFECF1EA),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: plantNotifier.notWateringPlantList != null
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: RefreshIndicator(
                onRefresh: () => refresh(plantNotifier),
                child: ListView(
                  children: plantNotifier.notWateringPlantList!.map((plant) {
                    return PlantListTile(plant: plant);
                  }).toList(),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
