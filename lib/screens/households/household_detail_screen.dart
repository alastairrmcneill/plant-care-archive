import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/household_notifier.dart';
import 'package:plant_care/screens/households/edit_household.dart';
import 'package:plant_care/services/database_service.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HouseholdDetail extends StatefulWidget {
  const HouseholdDetail({Key? key}) : super(key: key);

  @override
  State<HouseholdDetail> createState() => _HouseholdDetailState();
}

class _HouseholdDetailState extends State<HouseholdDetail> {
  @override
  void initState() {
    super.initState();

    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    HouseholdDatabaseService.getCurrentHouseholdMembers(householdNotifier);
    HouseholdDatabaseService.getCurrentHouseholdPlants(householdNotifier);
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    Household household = householdNotifier.currentHousehold!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print('share');
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditHousehold())),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AutoSizeText(
              household.name,
              maxLines: 2,
              wrapWords: true,
              minFontSize: 16,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 32, fontWeight: FontWeight.w400),
            ),
            Text(
              '(${household.code})',
              style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            householdNotifier.householdMembers != null && householdNotifier.householdPlants != null
                ? Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Plants'),
                            ...householdNotifier.householdPlants!.map((plant) => Text(plant.name)).toList(),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Members'),
                            ...householdNotifier.householdMembers!.map((member) => Text(member.firstName)).toList(),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}


///What to show 
///Name, code, share button 
///People
///Plants
///