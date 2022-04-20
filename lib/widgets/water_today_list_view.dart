import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class WaterTodayListView extends StatefulWidget {
  const WaterTodayListView({Key? key}) : super(key: key);

  @override
  _WaterTodayListViewState createState() => _WaterTodayListViewState();
}

class _WaterTodayListViewState extends State<WaterTodayListView> {
  @override
  void initState() {
    super.initState();

    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context, listen: false);
    // Replace with get water today plants.
    PlantDatabaseService.getTodaysWateringPlants(plantNotifier);
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    if (plantNotifier.waterPlantList == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (plantNotifier.waterPlantList!.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 17.0),
          child: Text(
            'No plants to water today',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w200,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text(
                'Water today',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w200,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: plantNotifier.waterPlantList!.map((plant) {
                  return WaterTodayPlantTile(plant: plant);
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }
  }
}
