import 'package:crud_r/presentation/pages/user/profile_page.dart';
import 'package:flutter/material.dart';
import '../../../infraestructure/repositories/user_repository_impl.dart';
import 'package:crud_r/domain/repositories/user_repository.dart';

class EditProfilePage extends StatefulWidget {
  final String token;
  final String userEmail;

  const EditProfilePage(
      {super.key, required this.token, required this.userEmail});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final UserRepository userRepository = UserRepositoryImpl();

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String staticAddress = '';

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final userProfile =
          await userRepository.getUserByEmail(widget.token, widget.userEmail);
      final password = await userRepository.getPassword();
      setState(() {
        nameController.text = userProfile['name'];
        lastNameController.text = userProfile['last_name'];
        emailController.text = userProfile['email'];
        phoneController.text = userProfile['phone_number'];
        staticAddress = userProfile['address'];
        passwordController.text = password ?? '';

      });
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> saveUserProfile() async {
    try {
      final userProfile = await userRepository.getUserByEmail(widget.token, widget.userEmail);
      await userRepository.updateUserProfile(widget.token, {
        'name': nameController.text,
        'last_name': lastNameController.text,
        'password': passwordController.text,
        'address': staticAddress,
        'phone_number': phoneController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado con éxito')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfilePage(token: widget.token, userEmail: widget.userEmail),
        ),
      );
    } catch (e) {
      print('Error updating user profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error actualizando el perfil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 60, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 60, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nombre',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Apellido',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    TextField(
                      controller: lastNameController,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Correo Electrónico',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Contraseña',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Número telefónico',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: 'Número de teléfono'),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ElevatedButton(
                          onPressed: saveUserProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF88B04F),
                            minimumSize: const Size(400, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text(
                            'Guardar cambios',
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
          ],
        ),
      ),
    );
  }
}
