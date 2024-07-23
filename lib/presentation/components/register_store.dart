import 'package:crud_r/infraestructure/repositories/user_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/repositories/user_repository.dart';
import 'dart:io';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rfcController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  TimeOfDay _openingTime = TimeOfDay.now();
  TimeOfDay _closingTime = TimeOfDay.now();
  String? _selectedCity;
  File? _image;

  final UserRepository _userRepository = UserRepositoryImpl();

  String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Por favor ingrese $fieldName";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor ingrese un número telefónico";
    } else {
      final regex = RegExp(r'^\+?1?\d{10}$');
      if (!regex.hasMatch(value)) {
        return "Por favor ingrese un número telefónico válido";
      }
    }
    return null;
  }

  Future<void> _createUser() async {
    if (_formKey.currentState!.validate()) {

    }
  }

  Future<void> _selectTime(BuildContext context, bool isOpening) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isOpening ? _openingTime : _closingTime,
    );
    if (picked != null && picked != (isOpening ? _openingTime : _closingTime)) {
      setState(() {
        if (isOpening) {
          _openingTime = picked;
        } else {
          _closingTime = picked;
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(),
                            child: Row(
                              children: [
                                Text(
                                  '¿Tienes un comercio?\n¡Regístralo!',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF464646),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'FiraSansCondensed',
                                    letterSpacing: 3.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: SizedBox(
                              width: 300,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      validator: (value) => validateNotEmpty(value, "el nombre"),
                                      decoration: const InputDecoration(
                                        labelText: 'Nombre',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _rfcController,
                                      validator: (value) => validateNotEmpty(value, "el RFC"),
                                      decoration: const InputDecoration(
                                        labelText: 'RFC',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _streetController,
                                      validator: (value) => validateNotEmpty(value, "la calle"),
                                      decoration: const InputDecoration(
                                        labelText: 'Calle',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _numberController,
                                      validator: (value) => validateNotEmpty(value, "el número"),
                                      decoration: const InputDecoration(
                                        labelText: 'Número',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _neighborhoodController,
                                      validator: (value) => validateNotEmpty(value, "la colonia"),
                                      decoration: const InputDecoration(
                                        labelText: 'Colonia',
                                      ),
                                    ),
                                    DropdownButtonFormField<String>(
                                      value: _selectedCity,
                                      items: const [
                                        DropdownMenuItem(value: 'Suchiapa', child: Text('Suchiapa')),
                                        DropdownMenuItem(value: 'Tuxtla', child: Text('Tuxtla')),
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedCity = newValue;
                                        });
                                      },
                                      validator: (value) => value == null ? 'Por favor seleccione una ciudad' : null,
                                      decoration: const InputDecoration(
                                        labelText: 'Ciudad',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _referenceController,
                                      validator: (value) => validateNotEmpty(value, "la referencia"),
                                      decoration: const InputDecoration(
                                        labelText: 'Referencia',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _phoneNumberController,
                                      validator: validatePhoneNumber,
                                      decoration: const InputDecoration(
                                        labelText: 'Número telefónico',
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _selectTime(context, true),
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: TextEditingController(text: _openingTime.format(context)),
                                          validator: (value) => validateNotEmpty(value, "la hora de apertura"),
                                          decoration: const InputDecoration(
                                            labelText: 'Hora de apertura',
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _selectTime(context, false),
                                      child: AbsorbPointer(
                                        child: TextFormField(
                                          controller: TextEditingController(text: _closingTime.format(context)),
                                          validator: (value) => validateNotEmpty(value, "la hora de cierre"),
                                          decoration: const InputDecoration(
                                            labelText: 'Hora de cierre',
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    GestureDetector(
                                      onTap: _pickImage,
                                      child: Container(
                                        color: Colors.grey[200],
                                        width: double.infinity,
                                        height: 150,
                                        child: _image == null
                                            ? const Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                                            : Image.file(_image!, fit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80, top: 30),
                            child: ElevatedButton(
                              onPressed: _createUser,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF88B04F),
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'FiraSansCondensed',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
