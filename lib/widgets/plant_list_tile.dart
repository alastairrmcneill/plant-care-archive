import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;
  const PlantListTile({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
                child: Image.asset(
                  'assets/icons/plant_icon.png',
                ),
              ),
              Text(plant.name),
            ],
          ),
        ),
      ),
    );
  }
}
