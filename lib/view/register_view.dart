import 'package:drink_app_flutter/model/network/auth_service.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _loading = false;

  void _onRegister() {
    if (_loading) return;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String name = _nameController.text;
    setState(() { _loading = true; });

    context.read<AuthService>().register(email, password, name).then((value) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registrado com sucesso!")),
        );
        GoRouter.of(context).go(DrinkAppRoutes.drinksView);
      }
    }).onError((error, stackTrace) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao registrar: $error")),
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
      title: "Registrar",
      showBottomAppBar: false,
      body: Center(
        child: Column(
          children: [
            Text("Registrar", style: Theme.of(context).textTheme.titleLarge),
            Text("Página de registro", style: Theme.of(context).textTheme.titleMedium),
            DrinkTextField(
              hintText: "Nome",
              controller: _nameController,
            ),
            DrinkTextField(
              hintText: "Email",
              controller: _emailController,
            ),
            DrinkTextField(
              hintText: "Senha",
              controller: _passwordController,
              obscureText: true,
            ),
            DrinkButton(text: 'Registrar', onPressed: _onRegister, isLoading: _loading)
          ]
        )
      ),
    );
  }
}