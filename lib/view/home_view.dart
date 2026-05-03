import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void _onRegister() {
    GoRouter.of(context).pushNamed(DrinkAppRoutes.registerView);
  }

  void _onLogin() {
    GoRouter.of(context).pushNamed(DrinkAppRoutes.loginView);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: "DrinkApp",
      showBottomAppBar: false,
      body: Center(
        child: Column(
          children: [
            Text("DrinkApp"),
            Text("Very cool landing page"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrinkButton(text: 'Register', onPressed: _onRegister),
                SizedBox(width: 16),
                DrinkButton(text: 'Login', onPressed: _onLogin),
              ],
            ),
          ]
        )
      ),
    );
  }
}
