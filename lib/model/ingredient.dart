import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(createJsonSchema: true)
class Ingredient {
  final String strIngredient;
  final String strDescription;
  final String strType;
  final String strAlcohol;
  final String strABV;

  Ingredient({required this.strIngredient, required this.strDescription, required this.strType, required this.strAlcohol, required this.strABV});

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientJsonSchema(this);

  static const jsonSchema = _$IngredientJsonSchema;
}
