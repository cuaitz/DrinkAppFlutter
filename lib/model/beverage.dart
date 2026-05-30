import 'package:drink_app_flutter/model/beverage_ingredient.dart';

class Beverage {
  final String? id;
  final String strDrink;
  final String? strCategory;
  final String? strGlass;
  final String? strInstructions;
  final String? strDrinkThumb;
  final String? strTags;
  final bool strAlcoholic;

  final List<BeverageIngredient> ingredients;

  Beverage({
    this.id,
    required this.strDrink,
    this.strCategory,
    this.strGlass,
    this.strInstructions,
    this.strDrinkThumb,
    this.strTags,
    required this.strAlcoholic,
    required this.ingredients,
  });

  factory Beverage.fromJson(Map<String, dynamic> json) {
    return Beverage(
      id: json['_id'],
      strDrink: json['strDrink'],
      strCategory: json['strCategory'],
      strGlass: json['strGlass'],
      strInstructions: json['strInstructions'],
      strDrinkThumb: json['strDrinkThumb'],
      strAlcoholic: json['strAlcoholic'] ?? false,
      strTags: json['strTags'],
      ingredients: (json['ingredients'] as List? ?? [])
          .map((e) => BeverageIngredient.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'strDrink': strDrink,
      'strCategory': strCategory,
      'strGlass': strGlass,
      'strInstructions': strInstructions,
      'strDrinkThumb': strDrinkThumb,
      'strAlcoholic': strAlcoholic,
      'strTags': strTags,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
    };
  }
}