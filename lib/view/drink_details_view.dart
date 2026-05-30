import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/model/network/drink_service.dart';
import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DrinkDetailsView extends StatefulWidget {
  final String drinkId;
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

  Future<Drink> _getDrink(String drinkId) async {
    return await context.read<DrinkService>().get(drinkId);
  }

  Widget _getImage() {
    final double size = MediaQuery.of(context).size.width * .5;

    Widget content;

    if (_drink?.strDrinkThumb != null && _drink!.strDrinkThumb!.isNotEmpty) {
      content = Image.network(
        _drink!.strDrinkThumb!,
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
      String? ingredient = _drink!.ingredients[i].name;
      String? measure = _drink!.ingredients[i].measure;

      if ((ingredient ?? '').isNotEmpty && (measure ?? '').isNotEmpty) {
        ingredients.add(Text("- $ingredient ($measure)", style: Theme.of(context).textTheme.bodyMedium));
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
      title: "Drink Details (${_drink!.strDrink})",
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getImage(),
              Text("Name: ${_drink!.strDrink}", style: Theme.of(context).textTheme.titleLarge),
              Text("Category: ${_drink!.strCategory ?? "Unknown"}", style: Theme.of(context).textTheme.titleMedium),
              Text("Instructions: ${_drink!.strInstructions ?? "Unknown"}", style: Theme.of(context).textTheme.bodyMedium),
              Text("Ingredients:", style: Theme.of(context).textTheme.bodyMedium),
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