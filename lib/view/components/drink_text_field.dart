import 'package:flutter/material.dart';

class DrinkTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool? enabled;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;

  const DrinkTextField({super.key, this.controller, this.hintText, this.labelText, this.enabled, this.onChanged, this.readOnly = false, this.obscureText = false, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
        readOnly: readOnly,
        obscureText: obscureText,
        maxLines: maxLines ?? 1,
      ),
    );
  }
}