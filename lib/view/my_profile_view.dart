import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:drink_app_flutter/model/network/auth_service.dart';
import 'package:drink_app_flutter/model/network/client.dart';
import 'package:drink_app_flutter/model/user.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  User? _user;
  bool _loading = false;
  bool _hasError = false;
  String? _errorMessage;

  void _onLogout() {
    try {
      context.read<ApiClient>().setAuth(null, null);
    } catch (_) {}

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sessão encerrada')));
    GoRouter.of(context).go(DrinkAppRoutes.homeView);
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    setState(() {
      _loading = true;
      _hasError = false;
      _errorMessage = null;
    });

    context.read<AuthService>().me().then((user) {
      if (!mounted) return;
      setState(() {
        _user = user;
      });
    }).catchError((error) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _errorMessage = error.toString();
      });
    }).whenComplete(() {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const DefaultView(
        title: 'Carregando perfil...',
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_hasError) {
      return DefaultView(
        title: 'Erro',
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Erro ao carregar perfil: ${_errorMessage ?? ''}'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loading ? null : _loadProfile,
                child: const Text('Tentar novamente'),
              )
            ],
          ),
        ),
      );
    }

    if (_user == null) {
      return const DefaultView(
        title: 'Perfil',
        body: Center(child: Text('Nenhum usuário disponível.')),
      );
    }

    return DefaultView(
      title: 'Meu Perfil',
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nome: ${_user!.name}', style: Theme.of(context).textTheme.titleMedium),
            Text('Email: ${_user!.email}', style: Theme.of(context).textTheme.bodyMedium),
            Text('Registrado em: ${_user!.createdAt?.toLocal().toString() ?? 'Desconhecido'}', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _onLogout,
              child: const Text('Sair'),
            )
          ],
        ),
      ),
    );
  }
}