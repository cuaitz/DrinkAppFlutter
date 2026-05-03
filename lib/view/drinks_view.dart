import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';

class DrinksView extends StatefulWidget {
  const DrinksView({super.key});

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

        bool inName = drink.name.toLowerCase().contains(value);
        bool inTags = drink.tags?.split(',').any((tag) => tag.toLowerCase().contains(value)) ?? false;
        bool inCategory = drink.category?.toLowerCase().contains(value) ?? false;
        bool inIngredients = drink.ingredients.any((ingredient) => ingredient?.toLowerCase().contains(value) ?? false);

        return inName || inTags || inCategory || inIngredients;
      }).toList();
    });
  }

  void _onDrinkTapped(Drink drink) {
    print("Tapped ${drink.name} (ID: ${drink.id})");
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _drinks = Drink.getMockDrinks();
      _filteredDrinks = _drinks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultView(
      title: 'Drinks',
      body: Center(
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
                  title: Text(drink.name),
                  subtitle: Text(drink.category ?? 'No category'),
                  onTap: () {
                    _onDrinkTapped(drink);
                  },
                );
              }
            )
          ]
        )
      )
    );
  }
}