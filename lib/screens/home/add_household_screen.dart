import 'package:flutter/material.dart';
import 'package:plant_care/widgets/widgets.dart';

class AddHousehold extends StatefulWidget {
  const AddHousehold({Key? key}) : super(key: key);

  @override
  State<AddHousehold> createState() => _AddHouseholdState();
}

class _AddHouseholdState extends State<AddHousehold> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Household'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            TextInputWidget(
              labelText: 'Name of household',
              isPassword: false,
              controller: _nameController,
            ),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  print('Create');
                },
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: 40),
            Row(children: const [
              Expanded(child: Divider()),
              Text("OR"),
              Expanded(child: Divider()),
            ]),
            const SizedBox(height: 30),
            TextInputWidget(
              labelText: 'Enter code here',
              isPassword: false,
              controller: _codeController,
            ),
            Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  print('Add');
                },
                child: const Text('Add'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
