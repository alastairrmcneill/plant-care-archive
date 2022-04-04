import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/database_service.dart';
import 'package:provider/provider.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  DateTime? pickedDate;
  TextEditingController nameController = TextEditingController();
  TextEditingController latinNameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController wateringFrequencyController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  Future<void> createPlant(PlantNotifier plantNotifier) async {
    Plant plant = Plant(
      name: nameController.text,
      latinName: latinNameController.text,
      room: roomController.text,
      notes: notesController.text,
      wateringFrequency: int.parse(wateringFrequencyController.text),
      lastWateredDate: Timestamp.fromDate(pickedDate!),
      nextWaterDate: Timestamp.fromDate(pickedDate!.add(Duration(days: int.parse(wateringFrequencyController.text)))),
      uid: '',
    );

    bool success = await PlantDatabaseService.createPlant(plantNotifier, plant);

    if (success) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plant'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              createPlant(plantNotifier);
            },
            icon: Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextFormField(
            controller: latinNameController,
            decoration: InputDecoration(labelText: 'Latin Name'),
          ),
          TextFormField(
            controller: roomController,
            decoration: InputDecoration(labelText: 'Room'),
          ),
          TextField(
            controller: dateTimeController, //editing controller of this TextField
            decoration: const InputDecoration(
                //icon of text field
                labelText: "Date Last Watered" //label text of field
                ),
            readOnly: true, //set it true, so that user will not able to edit text
            onTap: () async {
              pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate!);

                setState(() {
                  dateTimeController.text = formattedDate; //set output date to TextField value.
                });
              }
            },
          ),
          TextFormField(
            controller: wateringFrequencyController,
            decoration: InputDecoration(labelText: 'Watering Frequency'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: notesController,
            decoration: InputDecoration(labelText: 'Notes'),
          ),
        ],
      ),
    );
  }
}
