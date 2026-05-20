import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrinkDetailsView extends StatefulWidget {
  final int drinkId;
  const DrinkDetailsView({super.key, required this.drinkId});

  @override
  State<DrinkDetailsView> createState() => _DrinkDetailsViewState();
}

class _DrinkDetailsViewState extends State<DrinkDetailsView> {
  Drink? _drink;
  bool _isOwner = true; //! TO-DO: Adicionar a lógica para verificar se o drink pertence ao usuário logado

  @override
  void initState() {
    super.initState();

    _getDrink(widget.drinkId).then((drink) {
      setState(() {
        _drink = drink;
      });
    });
  }

  //! TO-DO: Fazer o fetch do drink real aqui
  Future<Drink> _getDrink(int drinkId) async {
    await Future.delayed(Duration(seconds: 2)); //! TO-DO: TIRAR ISSO DEPOIS
    return Drink.getMockDrinks().firstWhere((drink) => drink.id == drinkId);
  }

  Widget _getImage() {
    final double size = MediaQuery.of(context).size.width * .5;

    Widget content;

    if (_drink?.thumbnail != null && _drink!.thumbnail!.isNotEmpty) {
      content = Image.network(
        _drink!.thumbnail!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Icon(Icons.local_drink_outlined, size: size),
      );
    } else {
      content = Icon(Icons.local_drink_outlined, size: size);
    }

    return Center(
      child: SizedBox(
        width: size,
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.grey[300],
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getValidIngredients() {
    if (_drink == null) return [];

    List<Widget> ingredients = [];
    for (int i = 1; i < _drink!.ingredients.length; i++) {
      String? ingredient = _drink!.ingredients[i];
      String? measure = _drink!.measures[i];

      if (ingredient != null && ingredient.isNotEmpty && measure != null && measure.isNotEmpty) {
        ingredients.add(Text("- $ingredient ($measure)"));
      }
    }

    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    if (_drink == null) {
      return const DefaultView(
        title: "Drink Details",
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return DefaultView(
      title: "Drink Details (${_drink!.name})",
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getImage(),
              Text("Name: ${_drink!.name}"),
              Text("Category: ${_drink!.category ?? "Unknown"}"),
              Text("Glass: ${_drink!.glass ?? "Unknown"}"),
              Text("Instructions: ${_drink!.instructions ?? "Unknown"}"),
              Text("Ingredients:"),
              ..._getValidIngredients()
            ],
          ),
        ),
      ),
      floatingActionButton: _isOwner ? FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed(DrinkAppRoutes.manageDrinkView, queryParameters: {'id': _drink!.id.toString()});
        },
        child: const Icon(Icons.edit),
      ) : null,
    );
  }
}