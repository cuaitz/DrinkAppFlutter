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
    final promise = widget.ownDrinks
      ? context.read<DrinkService>().getUserDrinks()
      : context.read<DrinkService>().getAll();

    await promise.then((drinks) {
      setState(() {
        _drinks = drinks;
        _onFilterChanged(_filterController.text);
      });
    }).catchError((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao buscar drinks: $error")),
        );
      }
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
      title: widget.ownDrinks ? 'My Drinks' : 'Drinks',
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrinkTextField(
                controller: _filterController,
                hintText: "Filter by name, tags, category, ingredients, etc.",
                labelText: "Search for drinks",
                onChanged: _onFilterChanged,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredDrinks.length,
                itemBuilder: (context, index) {
                  final Drink drink = _filteredDrinks[index];
                  return ListTile(
                    title: Text(drink.strDrink ?? 'Unknown', style: Theme.of(context).textTheme.titleMedium,),
                    subtitle: Text(drink.strCategory ?? 'No category', style: Theme.of(context).textTheme.bodyMedium),
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