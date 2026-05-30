import 'package:drink_app_flutter/model/beverage.dart';
import 'package:drink_app_flutter/model/network/beverage_service.dart';
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

  List<Beverage> _drinks = [];
  List<Beverage> _filteredDrinks = [];

  void _onFilterChanged(String value) {
    setState(() {
      _filteredDrinks = _drinks.where((drink) {
        value = value.toLowerCase();

        bool inName = drink.strDrink.toLowerCase().contains(value);
        bool inTags = drink.strTags?.split(',').any((tag) => tag.toLowerCase().contains(value)) ?? false;
        bool inCategory = drink.strCategory?.toLowerCase().contains(value) ?? false;
        bool inIngredients = drink.ingredients.any((ingredient) => ingredient.ingredient.strIngredient.toLowerCase().contains(value));

        return inName || inTags || inCategory || inIngredients;
      }).toList();
    });
  }

  void _onDrinkTapped(Beverage drink) {
    print("Tapped ${drink.strDrink} (ID: ${drink.id})");
    GoRouter.of(context).pushNamed(DrinkAppRoutes.drinkDetailsView, pathParameters: {'id': drink.id.toString()});
  }

  void getDrinks() {
    //! TO-DO: Botar a logica de pegar todos/só os próprios drinks
    context.read<BeverageService>().getAll().then((drinks) {
      setState(() {
        _drinks = drinks;
        _filteredDrinks = drinks;
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

    setState(() {
      getDrinks();
    });
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
                  final Beverage drink = _filteredDrinks[index];
                  return ListTile(
                    title: Text(drink.strDrink, style: Theme.of(context).textTheme.titleMedium,),
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
          GoRouter.of(context).pushNamed(DrinkAppRoutes.manageDrinkView);
        },
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}