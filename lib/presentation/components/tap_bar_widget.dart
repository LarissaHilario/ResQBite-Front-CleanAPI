import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:crud_r/presentation/components/loading_page.dart';
import 'package:crud_r/presentation/components/register_store.dart';
import 'package:crud_r/presentation/pages/user/home_page.dart';
import 'package:crud_r/presentation/pages/user/location_page.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class TapBar extends StatefulWidget {
  const TapBar({Key? key}) : super(key: key);

  @override
  State<TapBar> createState() => _TapBarState();
}

class _TapBarState extends State<TapBar> {
  int currentIndex = 1;
  bool isLoading = false;

  Future<void> checkUserStore() async {
    setState(() {
      isLoading = true;
    });

    const String url = 'https://resqbite-gateway.integrador.xyz:3000/api/v1/user/user';
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['user']['store_uuid'] != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoadingPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterStorePage()),
        );
      }
    } else {
      // Manejar el error de la solicitud
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      const RegisterStorePage(),
      const HomeUserPage(),
      const LocationPage(),
    ];

    return Scaffold(
      body: Center(
        child: body[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFDDE4D9),
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: currentIndex,
        onTap: (int newIndex) {
          if (newIndex == 0) {
            checkUserStore();
          } else {
            setState(() {
              currentIndex = newIndex;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/store.svg'), label: 'Cambiar a tienda'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/home.svg'), label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/location.svg'), label: 'Ubicación'),
        ],
      ),
    );
  }
}
