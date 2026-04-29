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
    return MultiProvider(
      providers: [

      ],
      child: MaterialApp.router(
        routerConfig: drinkAppRouter,
        title: "DrinkApp",
        debugShowCheckedModeBanner: false,
      )
    );
  }
}
