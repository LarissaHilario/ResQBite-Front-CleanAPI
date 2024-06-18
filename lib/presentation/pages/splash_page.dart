import 'package:crud_r/presentation/pages/login_page.dart';
import 'package:crud_r/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';


class MyInitPage extends StatefulWidget {
  const MyInitPage({super.key});

  @override
  State<MyInitPage> createState() => _MyInitPageState();
}

class _MyInitPageState extends State<MyInitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Anuncio-img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30, bottom: 180),
              child: Row(
                children: [
                  Text(
                    'Únete a nuestra\ncomunidad para ayudar\nal planeta',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFF464646),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'FiraSansCondensed',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 45, bottom: 130),
              child: Text(
                'Rescata el sabor, salva el planeta.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF464646),
                  fontWeight: FontWeight.normal,
                  fontFamily: 'FiraSansCondensed',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF88B04F),
                  minimumSize: const Size(150, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 190, bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF88B04F)),
                  minimumSize: const Size(150, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Registro',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF464646),
                    fontWeight: FontWeight.normal,
                    fontFamily: 'FiraSansCondensed',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
