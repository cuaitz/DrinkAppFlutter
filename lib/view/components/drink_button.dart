import 'package:flutter/material.dart';

class DrinkButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isLoading;
  const DrinkButton({super.key, required this.text, required this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Theme.of(context).colorScheme.onPrimary))
          : Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
