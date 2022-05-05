import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:plant_care/models/models.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/database_service.dart';
import 'package:plant_care/widgets/widgets.dart';
import 'package:provider/provider.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  late String _name;
  late String _latinName;
  late String _room;
  late int _wateringFrequency;
  late String _notes;
  late DateTime _dateLastWatered;
  DateTime? _pickedDate;
  late String _household;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _dateTimeController = TextEditingController();

  Future<void> createPlant(PlantNotifier plantNotifier) async {
    Plant plant = Plant(
        uid: '',
        name: _name,
        lastWateredDate: Timestamp.fromDate(_dateLastWatered),
        nextWaterDate: Timestamp.fromDate(_dateLastWatered.add(Duration(days: _wateringFrequency))),
        wateringFrequency: _wateringFrequency,
        household: '1NMW8aD6Owv7trDlTTlC');

    bool success = await PlantDatabaseService.createPlant(plantNotifier, plant);

    if (success) {
      Navigator.pop(context);
    }
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
        textInputAction: TextInputAction.next,
        maxLines: 1,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
        },
        onSaved: (value) {
          _name = value!;
        },
      ),
    );
  }

  Widget _buildWateringFrequency() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'Watering Frequency (days)'),
        maxLines: 1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }

          int? freq = int.tryParse(value);

          if (freq == null || freq <= 0) {
            return 'Frequency must be greater than 0.';
          }

          return null;
        },
        onSaved: (value) {
          _wateringFrequency = int.parse(value!);
        },
      ),
    );
  }

  Widget _buildDateLastWatered() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dateTimeController,
        decoration: const InputDecoration(
          labelText: "Date Last Watered",
        ),
        readOnly: true,
        onTap: () async {
          _pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );

          if (_pickedDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(_pickedDate!);

            setState(() {
              _dateTimeController.text = formattedDate;
            });
          }
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
        },
        onSaved: (value) {
          _dateLastWatered = DateFormat('dd/MM/yyyy').parse(_dateTimeController.text);
        },
      ),
    );
  }

  Widget _buildHousehold() {
    List<String> items = [
      '128 Heron House',
      'Falmouth Road',
      '1281 Heron House',
      'Falmouths Road',
    ];
    String? selectedItem = items[0];

    return DropdownButtonFormField(
      value: selectedItem,
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: <Widget>[
              Text(item),
            ],
          ),
        );
      }).toList(),
      onChanged: (item) {
        setState(() {
          selectedItem = item as String;
        });
      },
      onSaved: (value) {
        _household = value as String;
      },
    );
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
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();

              createPlant(plantNotifier);
            },
            icon: Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildName(),
              _buildWateringFrequency(),
              _buildDateLastWatered(),
              _buildHousehold(),
            ],
          ),
        ),
      ),
    );
  }
}
