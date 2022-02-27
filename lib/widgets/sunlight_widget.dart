import 'package:flutter/material.dart';

class SunlightIcon extends StatelessWidget {
  const SunlightIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        color: Color(0xFFFFE5B3),
        borderRadius: BorderRadius.circular(11),
      ),
    );
  }
}
