import 'package:flutter/material.dart';
import 'package:plant_care/widgets/household_list_view.dart';

class HouseholdsScreen extends StatefulWidget {
  const HouseholdsScreen({Key? key}) : super(key: key);

  @override
  State<HouseholdsScreen> createState() => _HouseholdsScreenState();
}

class _HouseholdsScreenState extends State<HouseholdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Households'),
      ),
      body: HouseholdListView(),
    );
  }
}
