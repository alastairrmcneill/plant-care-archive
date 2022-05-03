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
                      Radius.circular(20),
                    ),
                  ),
                  child: Image.asset(
                    'assets/icons/plant_icon.png',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              plant.name,
                              maxLines: 2,
                              wrapWords: true,
                              minFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 22, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Location: ${plant.household}',
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            WateringTimeIcon(nextWateringDate: plant.nextWaterDate),
                            SizedBox(width: 10),
                            // SunlightIcon(),
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
