import 'dart:io';
import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/model/drink_ingredient.dart';
import 'package:drink_app_flutter/model/network/drink_service.dart';
import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ManageDrinkView extends StatefulWidget {
  final String? drinkId;
  const ManageDrinkView({super.key, this.drinkId});

  @override
  State<ManageDrinkView> createState() => _ManageDrinkViewState();
}

class _ManageDrinkViewState extends State<ManageDrinkView> {
  Drink? _drink;
  File? _pickedImage;
  bool _loading = false;
  bool _saving = false;
  bool _hasError = false;
  String? _errorMessage;

  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  final List<TextEditingController> _ingredientControllers = [];
  final List<TextEditingController> _measureControllers = [];

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  Widget _getImage() {
    final double size = MediaQuery.of(context).size.width * .5;

    Widget content;

    if (_pickedImage != null) {
      // Essa checagem só tá aqui pq eu testo as coisas pelo PC
      if (kIsWeb) {
        content = Image.network(
          _pickedImage!.path,
          fit: BoxFit.cover
        );
      } else {
        content = Image.file(
          _pickedImage!,
          fit: BoxFit.cover
        );
      }
    } else if (_drink?.strDrinkThumb != null && _drink!.strDrinkThumb!.isNotEmpty) {
      content = Image.network(
        _drink!.strDrinkThumb!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Icon(Icons.local_drink_outlined, size: size),
      );
    } else {
      content = Icon(Icons.local_drink_outlined, size: size);
    }

    return GestureDetector(
      onTap: _pickImage,
      child: Center(
        child: SizedBox(
          width: size,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.grey[300],
                child: Stack(
                  children: [
                    Positioned.fill(child: content),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveDrink() {
    final Drink drink = Drink(
      strDrink: _nameController.text,
      strCategory: _categoryController.text,
      strInstructions: _instructionsController.text,
      ingredients: List.generate(_ingredientControllers.length, (index) {
        final ingredientName = _ingredientControllers[index].text;
        final measure = _measureControllers[index].text;
        if (ingredientName.isEmpty && measure.isEmpty) {
          return null;
        }
        return DrinkIngredient(
          name: ingredientName,
          measure: measure,
        );
      }).whereType<DrinkIngredient>().toList(),
      strDrinkThumb: _pickedImage != null ? _pickedImage!.path : _drink?.strDrinkThumb,
    );

    setState(() {
      _saving = true;
    });

    final Future<Drink> saveFuture = widget.drinkId != null
      ? context.read<DrinkService>().update(widget.drinkId!, drink)
      : context.read<DrinkService>().create(drink);

    saveFuture.then((drink) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Drink ${drink.strDrink} ${widget.drinkId != null ? 'atualizado' : 'criado'} com sucesso!")),
        );
        Navigator.of(context).pop(true);
      }
    }).catchError((error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Falha ao ${widget.drinkId != null ? 'atualizar' : 'criar'} drink: $error")),
        );
      }
    }).whenComplete(() {
      if (!mounted) return;
      setState(() {
        _saving = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    updateFields();

    if (widget.drinkId != null) {
      setState(() {
        _loading = true;
        _hasError = false;
        _errorMessage = null;
      });

      _getDrink(widget.drinkId!).then((drink) {
        if (!mounted) return;
        setState(() {
          _drink = drink;
          updateFields();
        });
      }).catchError((error) {
        if (!mounted) return;
        setState(() {
          _hasError = true;
          _errorMessage = error.toString();
        });
      }).whenComplete(() {
        if (!mounted) return;
        setState(() {
          _loading = false;
        });
      });
    }
  }

  void updateFields() {
    _ingredientControllers.clear();
    _measureControllers.clear();

    if (_drink != null) {
      _nameController.text = _drink?.strDrink ?? '';
      _categoryController.text = _drink?.strCategory ?? '';
      _instructionsController.text = _drink?.strInstructions ?? '';
    
      for (int i = 0; i < 15; i++) {
        if (i < _drink!.ingredients.length) {
          _ingredientControllers.add(TextEditingController(text: _drink!.ingredients[i].name));
          _measureControllers.add(TextEditingController(text: _drink!.ingredients[i].measure));
        } else {
          _ingredientControllers.add(TextEditingController());
          _measureControllers.add(TextEditingController());
        }
      }
    } else {
      for (int i = 0; i < 15; i++) {
        _ingredientControllers.add(TextEditingController());
        _measureControllers.add(TextEditingController());
      }
    }
  }

  Future<Drink> _getDrink(String drinkId) async {
    return await context.read<DrinkService>().get(drinkId);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading && widget.drinkId != null) {
      return const DefaultView(
        title: 'Carregando drink...',
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_hasError && widget.drinkId != null) {
      return DefaultView(
        title: 'Erro',
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Erro ao carregar drink: ${_errorMessage ?? ''}'),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () {
                          setState(() {
                            _loading = true;
                            _hasError = false;
                            _errorMessage = null;
                          });
                          _getDrink(widget.drinkId!).then((drink) {
                            if (!mounted) return;
                            setState(() {
                              _drink = drink;
                              updateFields();
                            });
                          }).catchError((error) {
                            if (!mounted) return;
                            setState(() {
                              _hasError = true;
                              _errorMessage = error.toString();
                            });
                          }).whenComplete(() {
                            if (!mounted) return;
                            setState(() {
                              _loading = false;
                            });
                          });
                        },
                child: const Text('Tentar novamente'),
              )
            ],
          ),
        ),
      );
    }

    return DefaultView(
      title: _drink != null ? 'Editar ${_drink!.strDrink}' : 'Criar novo drink',
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(_drink != null ? 'Editando ${_drink!.strDrink}' : 'Criando um novo drink', style: Theme.of(context).textTheme.titleMedium),
              _getImage(),
              DrinkTextField(
                controller: _nameController,
                labelText: 'Nome',
                hintText: 'Digite o nome do drink',
              ),
              DrinkTextField(
                controller: _categoryController,
                labelText: 'Categoria',
                hintText: 'Digite a categoria do drink',
              ),
              DrinkTextField(
                controller: _instructionsController,
                labelText: 'Instruções',
                hintText: 'Digite as instruções de preparo',
                maxLines: 6,
              ),
              ...List.generate(_ingredientControllers.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: DrinkTextField(
                        controller: _ingredientControllers[index],
                        labelText: 'Ingrediente ${index + 1}',
                        hintText: 'Digite o nome do ingrediente',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: DrinkTextField(
                        controller: _measureControllers[index],
                        labelText: 'Medida ${index + 1}',
                        hintText: 'Digite a medida do ingrediente',
                      ),
                    ),
                  ],
                );
              }),
              _saving
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: CircularProgressIndicator(),
                  )
                : DrinkButton(
                    text: _drink != null ? 'Atualizar drink' : 'Criar drink',
                    onPressed: _saveDrink
                  )
            ]
          )
        )
      )
    );
  }
}
