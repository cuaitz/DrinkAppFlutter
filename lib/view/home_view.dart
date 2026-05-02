import 'package:drink_app_flutter/view/components/drink_app_bar.dart';
import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: "DrinkApp",
      body: Center(
        child: Column(
          children: [
            Text("DrinkApp"),
            Text("Very cool landing page"),
            DrinkButton(text: 'Start', onPressed: () {})
          ]
        )
      ),
    );
  }
}
