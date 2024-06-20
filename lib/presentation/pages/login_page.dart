
import 'package:crud_r/presentation/components/tap_bar_widget.dart';
import 'package:crud_r/presentation/pages/user/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _passwordVisible = ValueNotifier<bool>(false);
  bool _isEmailInValid = false;
  bool _isPasswordInValid = false;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor ingrese una contraseña";
    } else if (value.length < 8) {
      return "La contraseña debe tener al menos 8 caracteres";
    } else if (value.length > 15) {
      return "La contraseña no puede ser mayor a 15 caracteres";
    } else if (_isPasswordInValid) {
      return "La contraseña no existe";
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Por favor ingrese un email correcto';
    }
    if (_isEmailInValid) {
      return "El email no existe";
    }
    return null;
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      print('hola');
      try {
        print('si entré');
        final email = _emailController.text;
        final password = _passwordController.text;
        print('aqui voy');
        await Provider.of<UserProvider>(context, listen: false).login(
            email, password);
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const TapBar()),
        );
      } catch (error) {
        setState(() {
          _isEmailInValid = true;
          _isPasswordInValid = true;
        });
        _formKey.currentState?.validate();
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
                            image: AssetImage('assets/images/login-img.png'),
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
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 60),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF88B04F)
                                            .withOpacity(
                                            0.5),
                                        width: 3,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                          'assets/images/arrow-left.svg'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'RESQBITE',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Color(0xFF464646),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'FiraSansCondensed',
                                          letterSpacing: 3.5,
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Image.asset(
                                        'assets/images/logo.png',
                                        width: 40,
                                        height: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 115),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Bienvenido',
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
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width: 300,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _emailController,
                                            validator: (value) {
                                              return validateEmail(value);
                                            },
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFA0A0A7)),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFA0A0A7)),
                                              ),
                                              focusedErrorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              labelText: 'Correo electrónico',
                                              labelStyle: TextStyle(
                                                fontSize: 14.0,
                                                color: Color(0xFF000000),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable: _passwordVisible,
                                              builder: (context, value, child) {
                                                return TextFormField(
                                                  controller: _passwordController,
                                                  obscureText: !_passwordVisible
                                                      .value,
                                                  validator: (value) {
                                                    return validatePassword(
                                                        value);
                                                  },
                                                  decoration: InputDecoration(
                                                    border: const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFFA0A0A7)),
                                                    ),
                                                    focusedBorder: const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFFA0A0A7)),
                                                    ),
                                                    labelText: 'Contraseña',
                                                    labelStyle: const TextStyle(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF000000),
                                                      fontWeight: FontWeight
                                                          .w400,
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        _passwordVisible.value =
                                                        !_passwordVisible.value;
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
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 85, top: 40),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _formKey.currentState!.save();
                                      _loginUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF88B04F),
                                      minimumSize: const Size(200, 60),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: const Text(
                                      'Iniciar Sesión',
                                      style: TextStyle(
                                        fontSize: 20.0,
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
                  ]
              );
            }
        )
    );
  }
}
