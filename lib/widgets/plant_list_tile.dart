import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/screens/screens.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;
  const PlantListTile({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: GestureDetector(
        onTap: () {
          plantNotifier.setCurrentPlant = plant;
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantDetail()));
        },
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 12,
                      top: 4,
                      bottom: 4,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Plant name
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 42),
                                    child: AutoSizeText(
                                      plant.name,
                                      maxLines: 2,
                                      wrapWords: true,
                                      minFontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 22, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  // Latin name
                                  Text(
                                    plant.latinName != null ? '(${plant.latinName!})' : '',
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                              // Notes
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  plant.notes != null ? plant.notes! : '',
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12, fontWeight: FontWeight.w200),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Gap between two columns
                        const SizedBox(width: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Watering time
                            WateringTime(),
                            // Room
                            Text(
                              plant.room,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
