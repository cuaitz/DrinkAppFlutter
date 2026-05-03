import 'package:drink_app_flutter/view/components/drink_app_bar.dart';
import 'package:drink_app_flutter/view/components/drink_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class DefaultView extends StatelessWidget {
  final String? title;
  final Widget? body;
  final bool showBottomAppBar;

  const DefaultView({super.key, this.title, this.body, this.showBottomAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DrinkAppBar(title: title),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: body,
        )
      ),
      bottomNavigationBar: showBottomAppBar ? DrinkBottomAppBar() : null,
    );
  }
}