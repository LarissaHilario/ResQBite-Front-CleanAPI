
import 'package:crud_r/domain/models/user_model.dart';
import 'package:crud_r/infraestructure/repositories/user_repository_impl.dart';
import 'package:crud_r/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/repositories/user_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _cellphoneController = TextEditingController();

  final ValueNotifier<bool> _passwordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _confirmPasswordVisible = ValueNotifier<bool>(false);

  final UserRepository _userRepository = UserRepositoryImpl();

  void navigateLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor ingrese una contraseña";
    } else if (value.length < 8) {
      return "La contraseña debe tener al menos 8 caracteres";
    } else if (value.length > 15) {
      return "La contraseña no puede ser mayor a 15 caracteres";
    } else {
      return null;
    }
  }
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor ingrese un correo electrónico";
    } else {
      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!regex.hasMatch(value)) {
        return "Por favor ingrese un correo electrónico válido";
      }
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
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
        return;
      }

      try {
        final UserModel user = await _userRepository.registerUser(
          _usernameController.text,
          _lastnameController.text,
          _emailController.text,
          _passwordController.text,

        );

        // Handle successful registration
        navigateLoginScreen();
      } catch (e) {
        // Handle registration failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al registrar usuario')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/register.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, top: 50),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF88B04F).withOpacity(0.5),
                                  width: 3,
                                ),
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset('assets/images/arrow-left.svg'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              const Text(
                                'RESQBITE',
                                style: TextStyle(
                                  fontSize: 28.0,
                                  color: Color(0xFF464646),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 3.5,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Image.asset(
                                'assets/images/logo.png',
                                width: 45,
                                height: 45,
                              ),
                            ],
                          ),
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: 120),
                            child: Row(
                              children: [
                                Text(
                                  'Regístrate',
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
                                      controller: _emailController,
                                      validator: validateEmail,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                        ),
                                        labelText: 'Correo electrónico',
                                        labelStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _usernameController,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                        ),
                                        labelText: 'Nombre',
                                        labelStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _lastnameController,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                        ),
                                        labelText: 'Apellido',
                                        labelStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _cellphoneController,
                                      validator: validatePhoneNumber,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red),
                                        ),
                                        labelText: 'Número telefónico',
                                        labelStyle: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: _passwordVisible,
                                      builder: (context, value, child) {
                                        return TextFormField(
                                          controller: _passwordController,
                                          obscureText: !_passwordVisible.value,
                                          validator: (value) {
                                            return validatePassword(value);
                                          },
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                            ),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                            ),
                                            labelText: 'Contraseña',
                                            labelStyle: const TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                _passwordVisible.value = !_passwordVisible.value;
                                              },
                                              child: Icon(
                                                _passwordVisible.value
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: const Color(0xFF88B04F),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: _confirmPasswordVisible,
                                      builder: (context, value, child) {
                                        return TextFormField(
                                          controller: _confirmPasswordController,
                                          obscureText: !_confirmPasswordVisible.value,
                                          validator: (value) {
                                            return validatePassword(value);
                                          },
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                            ),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Color(0xFFA0A0A7)),
                                            ),
                                            labelText: 'Confirmar Contraseña',
                                            labelStyle: const TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xFF000000),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                _confirmPasswordVisible.value = !_confirmPasswordVisible.value;
                                              },
                                              child: Icon(
                                                _confirmPasswordVisible.value
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: const Color(0xFF88B04F),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
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
                              onPressed: () {
                                _createUser();
                              },
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
