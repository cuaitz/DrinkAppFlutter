import 'package:drink_app_flutter/model/network/auth_service.dart';
import 'package:drink_app_flutter/model/network/client.dart';
import 'package:drink_app_flutter/model/network/drink_service.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/components/theme.dart';
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
        Provider<ApiClient>(create: (_) => ApiClient()),
        Provider<AuthService>(
          create: (context) => AuthService(context.read<ApiClient>()),
        ),
        Provider<DrinkService>(
          create: (context) => DrinkService(context.read<ApiClient>().dio),
        ),
      ],
      child: MaterialApp.router(
        theme: DrinkAppTheme.light(),
        darkTheme: DrinkAppTheme.dark(),
        themeMode: ThemeMode.system,
        routerConfig: drinkAppRouter,
        title: "DrinkApp",
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
