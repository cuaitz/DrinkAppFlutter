import 'package:flutter/material.dart';

class DrinkTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? enabled;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool obscureText;

  const DrinkTextField({super.key, this.controller, this.hintText, this.labelText, this.enabled, this.onChanged, this.readOnly = false, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(),

      ),
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      readOnly: readOnly,
      obscureText: obscureText,
    );
  }
}