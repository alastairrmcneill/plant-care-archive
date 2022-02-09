import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;

  const TextInputWidget({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    required this.obscureText,
  }) : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          labelText: widget.labelText,
          suffixIcon: Icon(Icons.visibility_off_rounded),
          fillColor: Color(0xFF3a4d34).withOpacity(0.05),
        ),
      ),
    );
  }
}
