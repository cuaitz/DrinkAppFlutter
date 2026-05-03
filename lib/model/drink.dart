class Drink {
  final int id;
  final int? userId;
  final String name;
  final String? tags;
  final String? category;
  final String? glass;
  final String? instructions;
  final String? thumbnail;
  
  final String? ingredient1;
  final String? ingredient2;
  final String? ingredient3;
  final String? ingredient4;
  final String? ingredient5;
  final String? ingredient6;
  final String? ingredient7;
  final String? ingredient8;
  final String? ingredient9;
  final String? ingredient10;
  final String? ingredient11;
  final String? ingredient12;
  final String? ingredient13;
  final String? ingredient14;
  final String? ingredient15;

  List<String?> ingredients;

  final String? measure1;
  final String? measure2;
  final String? measure3;
  final String? measure4;
  final String? measure5;
  final String? measure6;
  final String? measure7;
  final String? measure8;
  final String? measure9;
  final String? measure10;
  final String? measure11;
  final String? measure12;
  final String? measure13;
  final String? measure14;
  final String? measure15;

  List<String?> measures;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Drink({
    required this.id,
    this.userId,
    required this.name,
    this.tags,
    this.category,
    this.glass,
    this.instructions,
    this.thumbnail,
    this.ingredient1,
    this.ingredient2,
    this.ingredient3,
    this.ingredient4,
    this.ingredient5,
    this.ingredient6,
    this.ingredient7,
    this.ingredient8,
    this.ingredient9,
    this.ingredient10,
    this.ingredient11,
    this.ingredient12,
    this.ingredient13,
    this.ingredient14,
    this.ingredient15,
    this.measure1,
    this.measure2,
    this.measure3,
    this.measure4,
    this.measure5,
    this.measure6,
    this.measure7,
    this.measure8,
    this.measure9,
    this.measure10,
    this.measure11,
    this.measure12,
    this.measure13,
    this.measure14,
    this.measure15,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt
  }) {
    ingredients = [
      ingredient1,
      ingredient2,
      ingredient3,
      ingredient4,
      ingredient5,
      ingredient6,
      ingredient7,
      ingredient8,
      ingredient9,
      ingredient10,
      ingredient11,
      ingredient12,
      ingredient13,
      ingredient14,
      ingredient15
    ];

    measures = [
      measure1,
      measure2,
      measure3,
      measure4,
      measure5,
      measure6,
      measure7,
      measure8,
      measure9,
      measure10,
      measure11,
      measure12,
      measure13,
      measure14,
      measure15
    ];
  }

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      tags: json['tags'],
      category: json['category'],
      glass: json['glass'],
      instructions: json['instructions'],
      thumbnail: json['thumbnail'],
      ingredient1: json['ingredient1'],
      ingredient2: json['ingredient2'],
      ingredient3: json['ingredient3'],
      ingredient4: json['ingredient4'],
      ingredient5: json['ingredient5'],
      ingredient6: json['ingredient6'],
      ingredient7: json['ingredient7'],
      ingredient8: json['ingredient8'],
      ingredient9: json['ingredient9'],
      ingredient10: json['ingredient10'],
      ingredient11: json['ingredient11'],
      ingredient12: json['ingredient12'],
      ingredient13: json['ingredient13'],
      ingredient14: json['ingredient14'],
      ingredient15: json['ingredient15'],
      measure1: json['measure1'],
      measure2: json['measure2'],
      measure3: json['measure3'],
      measure4: json['measure4'],
      measure5: json['measure5'],
      measure6: json['measure6'],
      measure7: json['measure7'],
      measure8: json['measure8'],
      measure9: json['measure9'],
      measure10: json['measure10'],
      measure11: json['measure11'],
      measure12: json['measure12'],
      measure13: json['measure13'],
      measure14: json['measure14'],
      measure15: json['measure15'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'tags': tags,
      'category': category,
      'glass': glass,
      'instructions': instructions,
      'thumbnail': thumbnail,
      'ingredient1': ingredient1,
      'ingredient2': ingredient2,
      'ingredient3': ingredient3,
      'ingredient4': ingredient4,
      'ingredient5': ingredient5,
      'ingredient6': ingredient6,
      'ingredient7': ingredient7,
      'ingredient8': ingredient8,
      'ingredient9': ingredient9,
      'ingredient10': ingredient10,
      'ingredient11': ingredient11,
      'ingredient12': ingredient12,
      'ingredient13': ingredient13,
      'ingredient14': ingredient14,
      'ingredient15': ingredient15,
      'measure1': measure1,
      'measure2': measure2,
      'measure3': measure3,
      'measure4': measure4,
      'measure5': measure5,
      'measure6': measure6,
      'measure7': measure7,
      'measure8': measure8,
      'measure9': measure9,
      'measure10': measure10,
      'measure11': measure11,
      'measure12': measure12,
      'measure13': measure13,
      'measure14': measure14,
      'measure15': measure15,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
