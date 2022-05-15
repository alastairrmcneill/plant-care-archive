import 'package:flutter/material.dart';
import 'package:plant_care/models/household_model.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/services.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

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
                onPressed: () async {
                  String code = await createHousehold(userNotifier, householdNotifier, _nameController.text.trim());
                  showHouseholdAddedDialog(
                    context: context,
                    title: 'Household created successfully',
                    message: code,
                  );
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
                onPressed: () async {
                  String code = _codeController.text.trim();
                  String name = await addHousehold(userNotifier, householdNotifier, code);
                  showHouseholdAddedDialog(
                    context: context,
                    title: 'House added successfully',
                    message: name,
                  );
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
