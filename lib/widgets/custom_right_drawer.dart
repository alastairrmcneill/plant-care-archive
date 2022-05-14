import 'package:flutter/material.dart';
import 'package:plant_care/screens/households/households_screen.dart';
import 'package:plant_care/screens/screens.dart';

import 'package:plant_care/services/auth_service.dart';
import 'package:plant_care/widgets/widgets.dart';

class CustomRightDrawer extends StatelessWidget {
  const CustomRightDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountSummary(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HouseholdsScreen())), child: Text('Households')),
                  TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationSettings())), child: Text('Notifications')),
                  TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountSettings())), child: Text('Account Settings')),
                  TextButton(onPressed: () => AuthService.signOut(), child: Text('Sign Out')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
