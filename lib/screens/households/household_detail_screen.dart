import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/household_notifier.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HouseholdDetail extends StatefulWidget {
  const HouseholdDetail({Key? key}) : super(key: key);

  @override
  State<HouseholdDetail> createState() => _HouseholdDetailState();
}

class _HouseholdDetailState extends State<HouseholdDetail> {
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
            onPressed: () {
              print('Edit');
            },
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
            Expanded(
              flex: 1,
              child: HouseholdPlants(),
            ),
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