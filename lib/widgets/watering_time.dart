import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_icons/weather_icons.dart';

class WateringTime extends StatelessWidget {
  const WateringTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        width: 70,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: Color(0xFFB2E3FF),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(-2, -3.5),
              child: const Icon(
                WeatherIcons.raindrop,
                color: Color(0xFF3AB8FF),
                size: 20,
              ),
            ),
            Text(
              '30 days',
              style: Theme.of(context).textTheme.headline4!.copyWith(color: const Color(0xFF3AB8FF), fontWeight: FontWeight.w700, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
