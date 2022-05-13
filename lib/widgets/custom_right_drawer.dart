import 'package:flutter/material.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AccountSummary(),
            Divider(),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Divider(),
            ElevatedButton(
              onPressed: AuthService.signOut,
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
