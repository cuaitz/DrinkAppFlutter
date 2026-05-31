import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/model/network/drink_service.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrinksView extends StatefulWidget {
  final bool ownDrinks;
  const DrinksView({super.key, required this.ownDrinks});

  @override
  State<DrinksView> createState() => _DrinksViewState();
}

class _DrinksViewState extends State<DrinksView> {
  final TextEditingController _filterController = TextEditingController();

  List<Drink> _drinks = [];
  List<Drink> _filteredDrinks = [];
  bool _loading = false;
  bool _hasError = false;
  String? _errorMessage;

  void _onFilterChanged(String value) {
    setState(() {
      _filteredDrinks = _drinks.where((drink) {
        value = value.toLowerCase();

        bool inName = drink.strDrink?.toLowerCase().contains(value) ?? false;
        bool inCategory = drink.strCategory?.toLowerCase().contains(value) ?? false;
        bool inIngredients = drink.ingredients.any((ingredient) => ingredient.name?.toLowerCase().contains(value) ?? false);

        return inName || inCategory || inIngredients;
      }).toList();
    });
  }

  void _onDrinkTapped(Drink drink) {
    print("Tapped ${drink.strDrink} (ID: ${drink.id})");
    GoRouter.of(context)
        .pushNamed(
          DrinkAppRoutes.drinkDetailsView,
          pathParameters: {'id': drink.id.toString()},
        )
        .then((_) {
          if (mounted) {
            getDrinks();
          }
        });
  }

  Future<void> getDrinks() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _hasError = false;
      _errorMessage = null;
    });

    try {
      final drinks = await (widget.ownDrinks
          ? context.read<DrinkService>().getUserDrinks()
          : context.read<DrinkService>().getAll());

      if (!mounted) return;
      setState(() {
        _drinks = drinks;
        _onFilterChanged(_filterController.text);
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _errorMessage = error.toString();
      });
    }

    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDrinks();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: widget.ownDrinks ? 'Minhas Bebidas' : 'Bebidas',
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrinkTextField(
                controller: _filterController,
                hintText: "Filtrar por nome, tags, categoria, ingredientes, etc.",
                labelText: "Pesquisar bebidas",
                onChanged: _onFilterChanged,
              ),

              if (_loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_hasError)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: [
                      Text('Erro ao buscar drinks: ${_errorMessage ?? ''}'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => getDrinks(),
                        child: const Text('Tentar novamente'),
                      )
                    ],
                  ),
                )
              else if (_filteredDrinks.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text('Nenhum drink disponível.', style: Theme.of(context).textTheme.bodyLarge),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredDrinks.length,
                  itemBuilder: (context, index) {
                    final Drink drink = _filteredDrinks[index];
                    return ListTile(
                      title: Text(drink.strDrink ?? 'Desconhecido', style: Theme.of(context).textTheme.titleMedium,),
                      subtitle: Text(drink.strCategory ?? 'Sem categoria', style: Theme.of(context).textTheme.bodyMedium),
                      onTap: () {
                        _onDrinkTapped(drink);
                      },
                    );
                  }
                )
            ]
          ),
        )
      ),
      floatingActionButton: widget.ownDrinks ? FloatingActionButton(
        onPressed: () {
          GoRouter.of(context)
              .pushNamed(DrinkAppRoutes.manageDrinkView)
              .then((_) {
                if (mounted) {
                  getDrinks();
                }
              });
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}