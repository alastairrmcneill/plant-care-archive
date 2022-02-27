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
    PlantDatabaseService.getAllPlants(plantNotifier);
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    return SizedBox(
      height: 200,
      child: plantNotifier.plantList == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                    children: plantNotifier.plantList!.map((plant) {
                      return WaterTodayPlantTile(plant: plant);
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
