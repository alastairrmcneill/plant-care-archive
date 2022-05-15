import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:plant_care/services/services.dart';
import 'package:provider/provider.dart';

class EditHousehold extends StatefulWidget {
  const EditHousehold({Key? key}) : super(key: key);

  @override
  State<EditHousehold> createState() => _EditHouseholdState();
}

class _EditHouseholdState extends State<EditHousehold> {
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    _nameController.text = householdNotifier.currentHousehold!.name;
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update name'),
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
              labelText: 'New name of household',
              isPassword: false,
              controller: _nameController,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      leaveHousehold(userNotifier, householdNotifier, plantNotifier);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Leave'),
                  ),
                ),
                Container(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateHousehold(userNotifier, householdNotifier, _nameController.text.trim());
                      Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
