import 'dart:io';

import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';
import 'package:crud_r/presentation/pages/admin/tap_bar_admi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../infraestructure/repositories/store/store_repository_impl.dart';
import '../providers/user_provider.dart';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key});

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  final _formKey = GlobalKey<FormState>();
  final _step1Key = GlobalKey<FormState>();
  final _step2Key = GlobalKey<FormState>();
  final _step3Key = GlobalKey<FormState>();

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

  final StoreRepository _storeRepository = StoreRepositoryImpl();

  int _currentStep = 0;

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

  Future<void> _createStore() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    if (_image == null) {
      print('Error: No se ha seleccionado ninguna imagen.');
      return;
    }

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token de usuario no encontrado.')),
      );
      return;
    }

    // Validar formularios de cada paso
    bool isStep1Valid = _step1Key.currentState?.validate() ?? false;
    bool isStep2Valid = _step2Key.currentState?.validate() ?? false;

    if (isStep1Valid && isStep2Valid) {
      try {
        await _storeRepository.createStore(
          name: _nameController.text,
          rfc: _rfcController.text,
          street: _streetController.text,
          number: _numberController.text,
          neighborhood: _neighborhoodController.text,
          reference: _referenceController.text,
          phone: _phoneNumberController.text,
          city: _selectedCity ?? '',
          openingTime: _openingTime.format(context),
          closingTime: _closingTime.format(context),
          image: _image!,
          token: token,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tienda registrada con éxito')),

        );
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const  TapBarAdmi()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar la tienda: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor complete todos los campos del formulario')),
      );
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Widget _buildStep1() {
    return Form(
      key: _step1Key,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (value) => validateNotEmpty(value, 'el nombre'),
          ),
          TextFormField(
            controller: _rfcController,
            decoration: const InputDecoration(labelText: 'RFC'),
            validator: (value) => validateNotEmpty(value, 'el RFC'),
          ),
          TextFormField(
            controller: _streetController,
            decoration: const InputDecoration(labelText: 'Calle'),
            validator: (value) => validateNotEmpty(value, 'la calle'),
          ),
          TextFormField(
            controller: _numberController,
            decoration: const InputDecoration(labelText: 'Número'),
            validator: (value) => validateNotEmpty(value, 'el número'),
          ),
        ],
      ),
    );
  }


  Widget _buildStep2() {
    return Form(
      key: _step2Key,
      child: Column(
        children: [
          TextFormField(
            controller: _neighborhoodController,
            decoration: const InputDecoration(labelText: 'Colonia'),
            validator: (value) => validateNotEmpty(value, 'la colonia'),
          ),
          TextFormField(
            controller: _referenceController,
            decoration: const InputDecoration(labelText: 'Referencia'),
            validator: (value) => validateNotEmpty(value, 'la referencia'),
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            validator: validatePhoneNumber,
          ),
          DropdownButtonFormField<String>(
            value: _selectedCity,
            items: ['Ciudad 1', 'Ciudad 2', 'Ciudad 3'].map((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCity = value;
              });
            },
            decoration: const InputDecoration(labelText: 'Ciudad'),
            validator: (value) => validateNotEmpty(value, 'la ciudad'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        ListTile(
          title: const Text('Hora de apertura'),
          trailing: Text(_openingTime.format(context)),
          onTap: () => _selectTime(context, true),
        ),
        ListTile(
          title: const Text('Hora de cierre'),
          trailing: Text(_closingTime.format(context)),
          onTap: () => _selectTime(context, false),
        ),
        _image == null
            ? const Text('No se ha seleccionado ninguna imagen')
            : Image.file(_image!),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Seleccionar imagen'),
        ),
      ],
    );
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '¿Tienes un comercio?',
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '¡Regístralo!',
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
                              child: Column(
                                children: [
                                  IndexedStack(
                                    index: _currentStep,
                                    children: [
                                      _buildStep1(),
                                      _buildStep2(),
                                      _buildStep3(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (_currentStep > 0)
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _currentStep--;
                                              print('Paso actual: $_currentStep');
                                            });
                                          },
                                          child: const Text('Anterior'),
                                        ),
                                      if (_currentStep < 2)
                                        ElevatedButton(
                                          onPressed: () {
                                            bool isValid = false;
                                            switch (_currentStep) {
                                              case 0:
                                                isValid = _step1Key.currentState!.validate();
                                                break;
                                              case 1:
                                                isValid = _step2Key.currentState!.validate();
                                                break;
                                              case 2:
                                                isValid = true; // Step 3 doesn't need validation
                                                break;
                                            }
                                            print('Resultado de la validación: $isValid');
                                            if (isValid) {
                                              setState(() {
                                                _currentStep++;
                                                print('Paso actual: $_currentStep');
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Por favor complete todos los campos')),
                                              );
                                            }
                                          },
                                          child: const Text('Siguiente'),
                                        ),
                                      if (_currentStep == 2)
                                        ElevatedButton(
                                          onPressed: _createStore,
                                          child: const Text('Registrarse'),
                                        ),
                                    ],
                                  ),
                                ],
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
