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
    PlantDatabaseService.getAllPlants(plantNotifier);
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
      child: plantNotifier.plantList != null
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: RefreshIndicator(
                onRefresh: () => PlantDatabaseService.getAllPlants(plantNotifier),
                child: ListView(
                  children: plantNotifier.plantList!.map((plant) {
                    return PlantListTile(plant: plant);
                  }).toList(),
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
