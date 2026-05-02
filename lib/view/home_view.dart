import 'package:drink_app_flutter/view/components/drink_app_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DrinkAppBar(),
      body: Center(
        child: Text("Home View"),
      ),
    );
  }
}
