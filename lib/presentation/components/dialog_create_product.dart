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

  void _showErrorSnackbar(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom + 50, // Ajusta según tu necesidad
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 50,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }


  void _createProduct() async {
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
      _showErrorSnackbar(e.toString());
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
                labelText: 'Descripción del Formato',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Descripción del formato',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _qualityController,
              decoration: InputDecoration(
                labelText: 'Calidad',
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF88B04F))),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Calidad',
                hintStyle: const TextStyle(
                  color: Color(0xFFAAAAAF),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 15),
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
            const SizedBox(height: 15),
            GestureDetector(
              onTap: _getImage,
              child: Container(
                color: Colors.grey[300],
                height: 150,
                width: double.infinity,
                child: _imageFile == null
                    ? Center(child: Text('Seleccionar Imagen'))
                    : Image.file(_imageFile!, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 1,
        state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Agregar Producto'),
      content: SizedBox(
        height: 600,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < _buildSteps().length - 1) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              _createProduct();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: _buildSteps(),
        ),
      ),
    );
  }
}
