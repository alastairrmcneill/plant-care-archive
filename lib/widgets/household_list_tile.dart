import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/household_notifier.dart';
import 'package:plant_care/screens/households/household_detail_screen.dart';
import 'package:provider/provider.dart';

class HouseholdTile extends StatelessWidget {
  final Household household;
  const HouseholdTile({Key? key, required this.household}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
      child: GestureDetector(
        onTap: () {
          householdNotifier.setCurrentHousehold = household;
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdDetail()));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          height: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AutoSizeText(
                household.name,
                maxLines: 2,
                wrapWords: true,
                minFontSize: 16,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              Divider(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Plants: ${household.plantCount}'),
                    Text('Members: ${household.memberCount}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
