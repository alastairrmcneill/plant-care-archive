import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/plant_service.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print('Edit');
            },
            icon: const Icon(Icons.edit_outlined),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 50,
            right: 50,
            bottom: 40,
            child: ElevatedButton(
              child: Text('Water'),
              onPressed: () {
                waterPlant(plantNotifier);
              },
            ),
          )
        ],
      ),
    );
  }
}
