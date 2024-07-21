import 'package:crud_r/presentation/pages/user/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../infraestructure/repositories/user_repository_impl.dart';
import '../splash_page.dart';
import 'package:crud_r/domain/repositories/user_repository.dart';

class ProfilePage extends StatefulWidget {
  final String token;
  final String userEmail;

  const ProfilePage({super.key, required this.token, required this.userEmail});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepository userRepository = UserRepositoryImpl();

  String name = '';
  String lastName = '';
  String email = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final userProfile = await userRepository.getUserByEmail(widget.token, widget.userEmail);
      setState(() {
        name = userProfile['name'];
        lastName = userProfile['last_name'];
        email = userProfile['email'];
        phone = userProfile['phone_number'];
      });
    } catch (e) {
      print('Error fetching user profile: $e');
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
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF88B04F).withOpacity(0.5),
                          width: 3,
                        ),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset('assets/images/edit.svg'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(token: widget.token, userEmail: widget.userEmail),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF88B04F).withOpacity(0.5),
                          width: 3,
                        ),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset('assets/images/log-out.svg'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyInitPage(),
                            ),
                          );
                        },
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
                    const SizedBox(height: 5),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const Divider(height: 10, thickness: 2, color: Color(0xFFA0A0A7)),
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
                    const SizedBox(height: 5),
                    Text(
                      lastName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const Divider(height: 10, thickness: 2, color: Color(0xFFA0A0A7)),
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
                    const SizedBox(height: 5),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const Divider(height: 10, thickness: 2, color: Color(0xFFA0A0A7)),
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
                    const SizedBox(height: 5),
                    Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 3.5,
                      ),
                    ),
                    const Divider(height: 10, thickness: 2, color: Color(0xFFA0A0A7)),
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
