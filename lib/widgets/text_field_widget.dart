import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String labelText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? submittedFunc;
  final Function(String)? onChanged;

  const TextInputWidget({
    Key? key,
    this.controller,
    this.focusNode,
    required this.labelText,
    this.prefixIcon,
    required this.isPassword,
    this.textInputAction,
    this.keyboardType,
    this.submittedFunc,
    this.onChanged,
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
        controller: widget.controller,
        autocorrect: false,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        onFieldSubmitted: (value) {
          if (widget.isPassword) {
            widget.submittedFunc!(value);
          }
        },
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon == null ? null : Icon(widget.prefixIcon),
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
        ),
      ),
    );
  }
}
