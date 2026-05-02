import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _onRegister() {
    // TO-DO: Implementar a lógica de registro

    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    print("Name: $name, Email: $email, Password: $password");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: "Register",
      body: Center(
        child: Column(
          children: [
            Text("Register"),
            Text("Very cool register page"),
            DrinkTextField(
              hintText: "Name",
              controller: _nameController,
            ),
            DrinkTextField(
              hintText: "Email",
              controller: _emailController,
            ),
            DrinkTextField(
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            DrinkButton(text: 'Register', onPressed: _onRegister)
          ]
        )
      ),
    );
  }
}