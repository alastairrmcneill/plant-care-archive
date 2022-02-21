import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/screens/screens.dart';
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
          Navigator.push(context, MaterialPageRoute(builder: (_) => PlantDetail()));
        },
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
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plant.name,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 22, fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      plant.latinName != null ? '(${plant.latinName!})' : '',
                                      maxLines: 1,
                                      style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                                Text(
                                  plant.notes != null ? plant.notes! : '',
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12, fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'in 33 days',
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 14),
                            ),
                            Text(
                              plant.room,
                              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // child: Padding(
                  //   padding: const EdgeInsets.only(top: 8.0, bottom: 4, left: 8, right: 8),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Flexible(
                  //             child: ConstrainedBox(
                  //               constraints: BoxConstraints(maxWidth: 150),
                  //               child: Text(
                  //                 plant.name,
                  //                 maxLines: 2,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 softWrap: true,
                  //                 style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20),
                  //               ),
                  //             ),
                  //           ),
                  //           Flexible(
                  //             child: ConstrainedBox(
                  //               constraints: BoxConstraints(maxWidth: 150),
                  //               child: Text(
                  //                 plant.latinName != null ? '(${plant.latinName})' : '',
                  //                 maxLines: 1,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                  //               ),
                  //             ),
                  //           ),
                  //           const SizedBox(height: 10),
                  //           Flexible(
                  //             child: ConstrainedBox(
                  //               constraints: BoxConstraints(maxWidth: 150),
                  //               child: Text(
                  //                 plant.notes != null ? '${plant.notes}' : '',
                  //                 maxLines: 2,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 10),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Expanded(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text('in 33 days'),
                  //             Text(plant.room),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
