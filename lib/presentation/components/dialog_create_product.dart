import 'dart:io';
import 'package:crud_r/domain/repositories/product_repository.dart';
import 'package:crud_r/domain/use_cases/add_product_usecase.dart';
import 'package:crud_r/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../infraestructure/repositories/user_repository_impl.dart';

class MyDialogAddProduct extends StatefulWidget {
  const MyDialogAddProduct({super.key});

  @override
  _MyDialogAddProductState createState() => _MyDialogAddProductState();
}

class _MyDialogAddProductState extends State<MyDialogAddProduct> {
  int _currentStep = 0;
  File? _imageFile;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _creationDateController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _formDescriptionController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _manipulationController = TextEditingController();
  String _selectedCategory = 'Lacteos';

  closeAlert() {
    Navigator.pop(context);
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _createProduct() async {
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (_imageFile == null) {
      print('Error: No se ha seleccionado ninguna imagen.');
      return;
    }

    if (token == null) {
      print('Error: No se ha encontrado el token.');
      return;
    }

    final email = Provider.of<UserProvider>(context, listen: false).user?.email;
    final userRepository = Provider.of<UserRepositoryImpl>(context, listen: false);
    final user = await userRepository.getUserByEmail(token!, email!);
    var storeId = user['store_uuid'];

    final createProductUseCase = Provider.of<CreateProductUseCase>(context, listen: false);

    try {
      await createProductUseCase.execute(
        token: token,
        name: _nameController.text,
        description: _descriptionController.text,
        price: _priceController.text,
        stock: _stockController.text,
        category: _selectedCategory,
        creationDate: _creationDateController.text,
        formDescription: _formDescriptionController.text,
        expirationDate: _expirationDateController.text,
        quality: _qualityController.text,
        manipulation: _manipulationController.text,
        image: _imageFile!,
        storeId: storeId,
      );
      closeAlert();
      print('El producto se creó correctamente');
    } catch (e) {
      print('Error al crear el producto: $e');
    }
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('Paso 1'),
        content: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Producto',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Escribe el nombre del producto',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Precio del Producto',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Precio del producto',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Descripción',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _stockController,
              decoration: InputDecoration(
                labelText: 'Stock',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Stock',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: ['Lacteos', 'Comida', 'Pasteleria', 'Panaderia']
                  .map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Categoría',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Selecciona una categoría',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text('Paso 2'),
        content: Column(
          children: [
            TextField(
              controller: _creationDateController,
              decoration: InputDecoration(
                labelText: 'Fecha de Creación',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Fecha de creación',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _expirationDateController,
              decoration: InputDecoration(
                labelText: 'Fecha de Expiración',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Fecha de expiración',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _formDescriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción del Formulario',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Descripción del formulario',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 1,
        state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: Text('Paso 3'),
        content: Column(
          children: [
            TextField(
              controller: _qualityController,
              decoration: InputDecoration(
                labelText: 'Calidad del Producto',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Calidad del producto',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 1),
            TextField(
              controller: _manipulationController,
              decoration: InputDecoration(
                labelText: 'Manipulación',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Manipulación',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 1),
            _imageFile != null
                ? Image.file(_imageFile!, width: 10, height: 10,)
                : Text('No se ha seleccionado ninguna imagen'),
            ElevatedButton(
              onPressed: _getImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF88B04F),
              ),
              child: const Text('Seleccionar Imagen'),
            ),
          ],
        ),
        isActive: _currentStep >= 2,
        state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      backgroundColor: const Color(0xFFFBFCF7),
      title: const Text(
        'Agregar Producto',
        style: TextStyle(color: Color(0xFF88B04F)),
      ),

      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
    child: SingleChildScrollView(
        child: Column(
          children: [
            Stepper(
              currentStep: _currentStep,
              onStepTapped: (step) => setState(() => _currentStep = step),
    onStepContinue: () {
    print('Current step: $_currentStep');
    if (_currentStep < _buildSteps().length - 1) {
    setState(() => _currentStep += 1);
    print('Moving to next step: $_currentStep');
    } else {
    print('Ejecutando _createProduct');
    _createProduct();
    }
    },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep -= 1);
                }
              },
              steps: _buildSteps(),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF88B04F),
                      ),
                      child: const Text('Continuar'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: details.onStepCancel,
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF88B04F),
                      ),
                      child: const Text('Atrás'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      ),
      actions: [
        ElevatedButton(
          onPressed: closeAlert,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF88B04F),
          ),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
