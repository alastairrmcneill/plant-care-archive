import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final Function(String)? submittedFunc;

  const TextInputWidget({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    required this.isPassword,
    required this.textInputAction,
    required this.keyboardType,
    this.submittedFunc,
  });

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        autocorrect: false,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        onFieldSubmitted: (value) {
          if (widget.isPassword) {
            widget.submittedFunc!(value);
          }
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          labelText: widget.labelText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText ? const Icon(Icons.visibility_off_rounded) : Icon(Icons.visibility_rounded),
                )
              : null,
          fillColor: const Color(0xFF3a4d34).withOpacity(0.1),
        ),
      ),
    );
  }
}
