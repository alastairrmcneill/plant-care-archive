import 'package:flutter/material.dart';
import 'package:plant_care/services/auth_service.dart';

class AccountSummary extends StatelessWidget {
  const AccountSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        // CircleAvatar(,)
        Icon(
          Icons.account_circle_rounded,
          size: 100,
          color: Color(0xFF1C3F37),
        ),
        Text(
          AuthService.getCurrentUsername(),
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
