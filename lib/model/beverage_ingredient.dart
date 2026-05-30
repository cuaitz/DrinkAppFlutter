// q q tu fez no backend simon...
import 'package:drink_app_flutter/model/ingredient.dart';

class BeverageIngredient {
  final Ingredient ingredient;
  final String ingredientAmount;

  BeverageIngredient({
    required this.ingredient,
    required this.ingredientAmount,
  });

  factory BeverageIngredient.fromJson(Map<String, dynamic> json) {
    return BeverageIngredient(
      ingredient: Ingredient.fromJson(json),
      ingredientAmount: json['ingredientAmount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = ingredient.toJson();
    data['ingredientAmount'] = ingredientAmount;
    return data;
  }
}