import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:provider/provider.dart';

class PlantDetail extends StatefulWidget {
  const PlantDetail({Key? key}) : super(key: key);

  @override
  _PlantDetailState createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return Container(
      child: Text(plantNotifier.currentPlant!.name),
    );
  }
}
