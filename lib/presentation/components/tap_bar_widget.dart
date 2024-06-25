import 'package:crud_r/presentation/pages/admin/home_page.dart';
import 'package:crud_r/presentation/pages/user/about_store_page.dart';
import 'package:crud_r/presentation/pages/user/home_page.dart';
import 'package:crud_r/presentation/pages/user/location_page.dart';
import 'package:crud_r/presentation/pages/user/login_store.dart';
import 'package:crud_r/presentation/pages/user/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TapBar extends StatefulWidget{

  const TapBar({ Key? key, }) : super(key: key);

  @override
  State<TapBar> createState() => _TapBarState();
}

class _TapBarState extends State<TapBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> body = [
      const StoreUserPage(),
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
        onTap: (int newIndex){
          setState(() {
            currentIndex=newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/store.svg'), label: 'Tienda'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/home.svg'), label: 'Home'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/images/location.svg'), label:'Ubicación'),

        ],

      ),

    );
  }
}