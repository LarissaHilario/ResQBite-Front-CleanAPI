import 'dart:convert';
import 'package:crud_r/presentation/components/tap_bar_widget.dart';
import 'package:crud_r/presentation/pages/admin/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:crud_r/presentation/components/loading_page.dart';
import 'package:crud_r/presentation/components/register_store.dart';
import 'package:crud_r/presentation/pages/user/home_page.dart';
import 'package:crud_r/presentation/pages/user/location_page.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';


class TapBarAdmi extends StatefulWidget {
  const TapBarAdmi({Key? key}) : super(key: key);

  @override
  State<TapBarAdmi> createState() => _TapBarAdmiState();
}

class _TapBarAdmiState extends State<TapBarAdmi> {
  int currentIndex = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      const HomeUserPage(),
      const HomePage(),
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TapBar()),
            );
          } else {
            setState(() {
              currentIndex = newIndex;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/changeuser.svg'), label: 'Cambiar a consumidor'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/home.svg'), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/add_prod.svg'), label: 'Mis productos'),
        ],
      ),
    );
  }
}
