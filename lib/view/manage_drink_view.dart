import 'dart:io';
import 'package:drink_app_flutter/model/drink.dart';
import 'package:drink_app_flutter/view/components/drink_button.dart';
import 'package:drink_app_flutter/view/components/drink_text_field.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManageDrinkView extends StatefulWidget {
  final int? drinkId;
  const ManageDrinkView({super.key, this.drinkId});

  @override
  State<ManageDrinkView> createState() => _ManageDrinkViewState();
}

class _ManageDrinkViewState extends State<ManageDrinkView> {
  Drink? _drink;
  File? _pickedImage;

  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _glassController = TextEditingController();
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
    } else if (_drink?.thumbnail != null && _drink!.thumbnail!.isNotEmpty) {
      content = Image.network(
        _drink!.thumbnail!,
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
    // TO-DO: Implement the logic to save or update the drink
    print('Saving drink: ${_nameController.text}');
  }

  @override
  void initState() {
    super.initState();
    updateFields();

    if (widget.drinkId != null) {
      _getDrink(widget.drinkId!).then((drink) {
        setState(() {
          _drink = drink;
          updateFields();
        });
      });
    }
  }

  void updateFields() {
    if (_drink != null) {
      _nameController.text = _drink!.name;
      _tagsController.text = _drink!.tags ?? '';
      _categoryController.text = _drink!.category ?? '';
      _glassController.text = _drink!.glass ?? '';
      _instructionsController.text = _drink!.instructions ?? '';
    
      for (int i = 0; i < _drink!.ingredients.length; i++) {
        _ingredientControllers.add(TextEditingController(text: _drink!.ingredients[i]));
        _measureControllers.add(TextEditingController(text: _drink!.measures[i]));
      }
    } else {
      _ingredientControllers.add(TextEditingController());
      _measureControllers.add(TextEditingController());
    }
  }

  //! TO-DO: Fazer o fetch do drink real aqui
  Future<Drink> _getDrink(int drinkId) async {
    return Drink.getMockDrinks().firstWhere((drink) => drink.id == drinkId);
  }

  @override
  Widget build(BuildContext context) {
    if (_drink == null && widget.drinkId != null) {
      return DefaultView(
        title: widget.drinkId != null ? 'Loading Drink...' : 'Create New Drink',
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultView(
      title: _drink != null ? 'Edit ${_drink!.name}' : 'Create New Drink',
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(_drink != null ? 'Editing ${_drink!.name}' : 'Creating a new drink'),
              _getImage(),
              DrinkTextField(
                controller: _nameController,
                labelText: 'Name',
                hintText: 'Enter the name of the drink',
              ),
              DrinkTextField(
                controller: _tagsController,
                labelText: 'Tags',
                hintText: 'Enter tags separated by commas',
              ),
              DrinkTextField(
                controller: _categoryController,
                labelText: 'Category',
                hintText: 'Enter the category of the drink',
              ),
              DrinkTextField(
                controller: _glassController,
                labelText: 'Glass Type',
                hintText: 'Enter the type of glass used',
              ),
              DrinkTextField(
                controller: _instructionsController,
                labelText: 'Instructions',
                hintText: 'Enter the preparation instructions',
                maxLines: 6,
              ),
              ...List.generate(_ingredientControllers.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: DrinkTextField(
                        controller: _ingredientControllers[index],
                        labelText: 'Ingredient ${index + 1}',
                        hintText: 'Enter ingredient name',
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: DrinkTextField(
                        controller: _measureControllers[index],
                        labelText: 'Measure ${index + 1}',
                        hintText: 'Enter measure for ingredient',
                      ),
                    ),
                  ],
                );
              }),
              DrinkButton(
                text: _drink != null ? 'Update Drink' : 'Create Drink',
                onPressed: _saveDrink
              )
            ]
          )
        )
      )
    );
  }
}
