class Ingredient {
  final String? id;
  final String strIngredient;
  final String? strDescription;
  final String? strType;
  final bool strAlcohol;
  final String? strABV;

  Ingredient({
    this.id,
    required this.strIngredient,
    this.strDescription,
    this.strType,
    required this.strAlcohol,
    this.strABV,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['_id'],
      strIngredient: json['strIngredient'],
      strDescription: json['strDescription'],
      strType: json['strType'],
      strAlcohol: json['strAlcohol'] ?? false,
      strABV: json['strABV'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'strIngredient': strIngredient,
      'strDescription': strDescription,
      'strType': strType,
      'strAlcohol': strAlcohol,
      'strABV': strABV,
    };
  }
}