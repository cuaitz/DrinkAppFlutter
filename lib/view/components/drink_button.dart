import 'package:flutter/material.dart';

class DrinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const DrinkButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text)
    );
  }
}
