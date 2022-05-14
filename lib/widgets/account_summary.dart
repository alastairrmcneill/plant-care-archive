import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/auth_service.dart';
import 'package:provider/provider.dart';

class AccountSummary extends StatelessWidget {
  const AccountSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        // CircleAvatar(,)
        Icon(
          Icons.account_circle_rounded,
          size: 100,
          color: Color(0xFF1C3F37),
        ),
        Text(
          '${userNotifier.currentUser!.firstName} ${userNotifier.currentUser!.lastName}',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [Text('Plants'), Text('${plantNotifier.notWateringPlantList!.length + plantNotifier.waterPlantList!.length}')],
            ),
            Column(
              children: [
                Text('Households'),
                Text('${userNotifier.currentUser!.households.length}'),
              ],
            ),
          ],
        )
      ],
    );
  }
}
