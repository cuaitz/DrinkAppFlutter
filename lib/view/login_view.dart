import 'package:drink_app_flutter/model/network/auth_service.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLogin() {
    String email = _emailController.text;
    String password = _passwordController.text;
    
    context.read<AuthService>().login(email, password).then((value) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Logado com sucesso!")),
        );
        GoRouter.of(context).go(DrinkAppRoutes.drinksView);
      }
    }).onError((error, stackTrace) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao fazer login: $error")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: "Login",
      showBottomAppBar: false,
      body: Center(
        child: Column(
          children: [
            Text("Login", style: Theme.of(context).textTheme.titleLarge),
            Text("This is the login page", style: Theme.of(context).textTheme.titleMedium),
            DrinkTextField(
              hintText: "Username",
              controller: _emailController,
            ),
            DrinkTextField(
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            DrinkButton(text: 'Login', onPressed: _onLogin)
          ]
        )
      ),
    );
  }
}