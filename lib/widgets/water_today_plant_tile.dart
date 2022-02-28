import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class WaterTodayPlantTile extends StatefulWidget {
  final Plant plant;
  const WaterTodayPlantTile({Key? key, required this.plant}) : super(key: key);

  @override
  _WaterTodayPlantTileState createState() => _WaterTodayPlantTileState();
}

class _WaterTodayPlantTileState extends State<WaterTodayPlantTile> {
  bool watered = false;
  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 20),
      child: GestureDetector(
        onTap: () {
          plantNotifier.setCurrentPlant = widget.plant;
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantDetail()));
        },
        onLongPress: () {
          setState(() {
            watered = !watered;
          });
          HapticFeedback.vibrate();
        },
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.green,
                    child: Image.asset(
                      'assets/icons/plant_icon.png',
                    ),
                  ),
                ),
                watered
                    ? Container()
                    : Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      widget.plant.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    watered ? Icons.check_rounded : TablerIcons.droplet,
                    color: Color(0xFFECF1EA),
                    size: 80,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
