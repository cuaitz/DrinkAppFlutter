import 'package:flutter/material.dart';

class DrinkAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const DrinkAppBar({super.key, this.title = 'DrinkApp'});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? 'DrinkApp'),
    );
  }
}
