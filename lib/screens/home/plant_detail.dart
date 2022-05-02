import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/notifiers/notifiers.dart';
import 'package:plant_care/services/plant_service.dart';
import 'package:provider/provider.dart';

class PlantDetail extends StatefulWidget {
  const PlantDetail({Key? key}) : super(key: key);

  @override
  _PlantDetailState createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  String buildDate(PlantNotifier plantNotifier) {
    DateTime date = plantNotifier.currentPlant!.nextWaterDate.toDate();

    return 'Water next - ${date.day}/${date.month}/${date.year}';
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              print('Edit');
            },
            icon: const Icon(Icons.edit_outlined),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 50,
            right: 50,
            bottom: 40,
            child: ElevatedButton(
              child: Text('Water'),
              onPressed: () {
                waterPlant(plantNotifier);
                showAlertDialog(context);
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Image.asset(
                  'assets/icons/plant_icon.png',
                ),
              ),
              AutoSizeText(
                plantNotifier.currentPlant!.name,
                maxLines: 2,
                wrapWords: true,
                minFontSize: 16,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 32, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              Text(buildDate(plantNotifier))
            ],
          )
        ],
      ),
    );
  }
}
