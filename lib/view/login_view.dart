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
  bool _loading = false;

  void _onLogin() {
    if (_loading) return;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    setState(() { _loading = true; });

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
    }).whenComplete(() {
      if (!mounted) return;
      setState(() { _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: "Entrar",
      showBottomAppBar: false,
      body: Center(
        child: Column(
          children: [
            Text("Entrar", style: Theme.of(context).textTheme.titleLarge),
            Text("Página de login", style: Theme.of(context).textTheme.titleMedium),
            DrinkTextField(
              hintText: "Email",
              controller: _emailController,
            ),
            DrinkTextField(
              hintText: "Senha",
              controller: _passwordController,
              obscureText: true,
            ),
            DrinkButton(text: 'Entrar', onPressed: _onLogin, isLoading: _loading)
          ]
        )
      ),
    );
  }
}