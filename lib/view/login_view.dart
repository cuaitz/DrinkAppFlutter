import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLogin() {
    // TO-DO: Implementar a lógica de login

    String email = _emailController.text;
    String password = _passwordController.text;

    print("Email: $email, Password: $password");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: "Login",
      body: Center(
        child: Column(
          children: [
            Text("Login"),
            Text("This is the login page"),
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