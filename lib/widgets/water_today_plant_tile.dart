import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/screens/screens.dart';
import 'package:provider/provider.dart';

class WaterTodayPlantTile extends StatelessWidget {
  final Plant plant;
  const WaterTodayPlantTile({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 20),
      child: GestureDetector(
        onTap: () {
          plantNotifier.setCurrentPlant = plant;
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantDetail()));
        },
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.green,
              child: Image.asset(
                'assets/icons/plant_icon.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
