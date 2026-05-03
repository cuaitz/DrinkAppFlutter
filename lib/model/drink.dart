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

  List<String?> ingredients = [];

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

  List<String?> measures = [];

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

  //! TO-DO: Remover quando a API de vdd entrar
  //! TO-DO: Criar uma lista dos 100 coquetéis 
  //! mais populares e deixar salva localmente?
  static List<Drink> getMockDrinks() {
    return [
      Drink(
        id: 1,
        name: "Mojito",
        category: "Cocktail",
        glass: "Highball glass",
        instructions: "Muddle mint leaves with sugar and lime juice. Add a splash of soda water and fill the glass with cracked ice. Pour the rum and top with soda water. Garnish and serve with straw.",
        thumbnail: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
        ingredient1: "Light rum",
        ingredient2: "Lime",
        ingredient3: "Sugar",
        ingredient4: "Mint",
        ingredient5: "Soda water",
        measure1: "2-3 oz ",
        measure2: "Juice of 1 ",
        measure3: "2 tsp ",
        measure4: "2-4 ",
        measure5: "Top up with",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      ),
      Drink(
        id: 2,
        name: "Old Fashioned",
        category: "Cocktail",
        glass: "Old-fashioned glass",
        instructions: "Place sugar cube in old fashioned glass and saturate with bitters, add a dash of plain water. Muddle until dissolved. Fill the glass with ice cubes and add whiskey. Garnish with orange slice and a cocktail cherry.",
        thumbnail: "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg",
        ingredient1: "Bourbon",
        ingredient2: "Angostura bitters",
        ingredient3: "Sugar",
        ingredient4: "Water",
        measure1: "4.5 cL ",
        measure2: "2 dashes ",
        measure3: "1 cube ",
        measure4: "dash",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      ),

      Drink(
        id: 3,
        name: "Margarita",
        category: "Cocktail",
        glass: "Cocktail glass",
        instructions: "Rub the rim with lime slice to make the salt stick. Shake ingredients with ice, strain into the glass.",
        thumbnail: "https://example.com/margarita.jpg",
        ingredient1: "Tequila",
        ingredient2: "Triple sec",
        ingredient3: "Lime juice",
        ingredient4: "Salt",
        measure1: "2 oz ",
        measure2: "1 oz ",
        measure3: "1 oz ",
        measure4: "Pinch",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      ),

      Drink(
        id: 4,
        name: "Piña Colada",
        category: "Cocktail",
        glass: "Hurricane glass",
        instructions: "Blend all ingredients with ice until smooth. Pour into glass and garnish.",
        thumbnail: "https://example.com/pinacolada.jpg",
        ingredient1: "White rum",
        ingredient2: "Coconut cream",
        ingredient3: "Pineapple juice",
        measure1: "2 oz ",
        measure2: "2 oz ",
        measure3: "4 oz ",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      ),

      Drink(
        id: 5,
        name: "Negroni",
        category: "Cocktail",
        glass: "Old-fashioned glass",
        instructions: "Stir into glass over ice, garnish and serve.",
        thumbnail: "https://example.com/negroni.jpg",
        ingredient1: "Gin",
        ingredient2: "Campari",
        ingredient3: "Sweet vermouth",
        measure1: "1 oz ",
        measure2: "1 oz ",
        measure3: "1 oz ",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      ),

      Drink(
        id: 6,
        name: "Espresso Martini",
        category: "Cocktail",
        glass: "Cocktail glass",
        instructions: "Shake all ingredients with ice, strain into chilled glass.",
        thumbnail: "https://example.com/espresso_martini.jpg",
        ingredient1: "Vodka",
        ingredient2: "Espresso",
        ingredient3: "Coffee liqueur",
        ingredient4: "Sugar syrup",
        measure1: "1.5 oz ",
        measure2: "1 oz ",
        measure3: "0.5 oz ",
        measure4: "0.5 oz ",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
      ),
    ];
  }
}
