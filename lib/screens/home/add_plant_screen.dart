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
  late String _name;
  late String _latinName;
  late String _room;
  late String _wateringFrequency;
  late String _notes;
  late String _dateLastWatered;
  DateTime? pickedDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void createPlant(PlantNotifier plantNotifier) {}

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
      ),
      validator: (value) {
        print(value);
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildWateringFrequency() {
    return TextFormField();
  }

  Widget _buildDateLastWatered() {
    return TextFormField();
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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildName(),
            _buildWateringFrequency(),
            _buildDateLastWatered(),
          ],
        ),
      ),
    );
  }
}


// TextField(
//             controller: dateTimeController, //editing controller of this TextField
//             decoration: const InputDecoration(
//                 //icon of text field
//                 labelText: "Date Last Watered" //label text of field
//                 ),
//             readOnly: true, //set it true, so that user will not able to edit text
//             onTap: () async {
//               pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime.now(),
//               );

//               if (pickedDate != null) {
//                 String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate!);

//                 setState(() {
//                   dateTimeController.text = formattedDate; //set output date to TextField value.
//                 });
//               }
//             },
//           ),