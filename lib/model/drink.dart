import 'package:drink_app_flutter/model/drink_ingredient.dart';

class Drink {
  final String? id;
  final String? userId;
  final String? strDrink;
  final String? strCategory;
  final String? strInstructions;
  final String? strDrinkThumb;

  final List<DrinkIngredient> ingredients;

  Drink({
    this.id,
    this.userId,
    this.strDrink,
    this.strCategory,
    this.strInstructions,
    this.strDrinkThumb,
    required this.ingredients,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    List<DrinkIngredient> ingredients = [];

    for (int i = 1; i <= 15; i++) {
      final name = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (name != null && name.toString().isNotEmpty) {
        ingredients.add(DrinkIngredient(name: name, measure: measure));
      }
    }

    return Drink(
      id: json['_id'],
      userId: json['user_id'],
      strDrink: json['strDrink'],
      strCategory: json['strCategory'],
      strInstructions: json['strInstructions'],
      strDrinkThumb: json['strDrinkThumb'],
      ingredients: ingredients,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'user_id': userId,
      'strDrink': strDrink,
      'strCategory': strCategory,
      'strInstructions': strInstructions,
      'strDrinkThumb': strDrinkThumb,
    };

    for (int i = 0; i < ingredients.length && i < 15; i++) {
      data['strIngredient${i + 1}'] = ingredients[i].name;
      data['strMeasure${i + 1}'] = ingredients[i].measure;
    }

    return data;
  }
}
