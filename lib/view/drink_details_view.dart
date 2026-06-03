import 'dart:convert';

import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/model/network/client.dart';
import 'package:drink_app_flutter/model/network/drink_service.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrinkDetailsView extends StatefulWidget {
  final String drinkId;
  const DrinkDetailsView({super.key, required this.drinkId});

  @override
  State<DrinkDetailsView> createState() => _DrinkDetailsViewState();
}

class _DrinkDetailsViewState extends State<DrinkDetailsView> {
  Drink? _drink;
  bool _isOwner = false;
  bool _loading = false;
  bool _hasError = false;
  String? _errorMessage;

  bool _checkIsOwner(Drink drink) {
    final currentUserId = context.read<ApiClient>().userId;
    return drink.userId != null &&
        currentUserId != null &&
        drink.userId == currentUserId;
  }

  @override
  void initState() {
    super.initState();

    _loadDrink();
  }

  void _loadDrink() {
    setState(() {
      _loading = true;
      _hasError = false;
      _errorMessage = null;
    });

    _getDrink(widget.drinkId).then((drink) {
      if (!mounted) return;
      setState(() {
        _drink = drink;
        _isOwner = _checkIsOwner(drink);
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

  Future<Drink> _getDrink(String drinkId) async {
    return await context.read<DrinkService>().get(drinkId);
  }

  Widget _getImage() {
    final double size = MediaQuery.of(context).size.width * .5;

    Widget content;

    if (_drink?.strDrinkThumb != null && _drink!.strDrinkThumb!.isNotEmpty) {
      try {
        final imageBytes = base64.decode(_drink!.strDrinkThumb!.contains(',') ? _drink!.strDrinkThumb!.split(',').last : _drink!.strDrinkThumb!);
        content = Image.memory(
          imageBytes,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Icon(Icons.local_drink_outlined, size: size),
        );
      } catch (e) {
        content = Icon(Icons.local_drink_outlined, size: size);
      }
    } else {
      content = Icon(Icons.local_drink_outlined, size: size);
    }

    return Center(
      child: SizedBox(
        width: size,
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.grey[300],
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getValidIngredients() {
    if (_drink == null) return [];

    List<Widget> ingredients = [];
    for (int i = 1; i < _drink!.ingredients.length; i++) {
      String? ingredient = _drink!.ingredients[i].name;
      String? measure = _drink!.ingredients[i].measure;

      if ((ingredient ?? '').isNotEmpty && (measure ?? '').isNotEmpty) {
        ingredients.add(Text("- $ingredient ($measure)", style: Theme.of(context).textTheme.bodyMedium));
      }
    }

    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const DefaultView(
        title: "Detalhes do Drink",
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
              Text('Erro ao carregar detalhes: ${_errorMessage ?? ''}'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loading ? null : _loadDrink,
                child: const Text('Tentar novamente'),
              )
            ],
          ),
        ),
      );
    }
    
    return DefaultView(
      title: "Detalhes do Drink (${_drink?.strDrink})",
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getImage(),
              Text("Nome: ${_drink!.strDrink}", style: Theme.of(context).textTheme.titleLarge),
              Text("Categoria: ${_drink!.strCategory ?? "Desconhecido"}", style: Theme.of(context).textTheme.titleMedium),
              Text("Instruções: ${_drink!.strInstructions ?? "Desconhecido"}", style: Theme.of(context).textTheme.bodyMedium),
              Text("Ingredientes:", style: Theme.of(context).textTheme.bodyMedium),
              ..._getValidIngredients()
            ],
          ),
        ),
      ),
      floatingActionButton: _isOwner ? FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(DrinkAppRoutes.manageDrinkView, queryParameters: {'id': _drink!.id.toString()}).then((shouldRefresh) {
            if (shouldRefresh == true) {
              setState(() {
                _loading = true;
              });
              _getDrink(widget.drinkId).then((drink) {
                if (!mounted) return;
                setState(() {
                  _drink = drink;
                  _isOwner = _checkIsOwner(drink);
                });
              }).whenComplete(() {
                if (!mounted) return;
                setState(() {
                  _loading = false;
                });
              });
            }
          });
        },
        child: const Icon(Icons.edit),
      ) : null,
    );
  }
}