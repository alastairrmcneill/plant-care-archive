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
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        labelText: widget.labelText,
        suffixIcon: isValid ? Icon(Icons.check) : null,
      ),
    );
  }
}
