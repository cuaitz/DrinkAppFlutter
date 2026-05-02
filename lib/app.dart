import 'package:drink_app_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrinkApp extends StatefulWidget {
  const DrinkApp({super.key});

  @override
  State<DrinkApp> createState() => _DrinkAppState();
}

class _DrinkAppState extends State<DrinkApp> {
  @override
  Widget build(BuildContext context) {
    // TO-DO: Adicionar os provider aqui no futuro
    return MaterialApp.router(
      routerConfig: drinkAppRouter,
      title: "DrinkApp",
      debugShowCheckedModeBanner: false,
    );
  }
}
