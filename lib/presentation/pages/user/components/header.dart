import 'package:crud_r/presentation/components/categories.dart';
import 'package:crud_r/presentation/pages/user/shopping_basket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../components/search_bar.dart';
import '../../../providers/user_provider.dart';
import '../profile_page.dart';

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({super.key});

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final token = userProvider.user?.token;
    final userEmail = userProvider.user?.email ?? '';

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'RESQBITE',
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Color(0xFF464646),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'FiraSansCondensed',
                    letterSpacing: 5,
                  ),
                ),
                const SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingBasketPage(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 45,
                    height: 45,
                    child: SvgPicture.asset(
                      'assets/images/bag.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    if (token != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            token: token,
                            userEmail: userEmail,
                          ),
                        ),
                      );
                    }
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'assets/images/avatar.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const SearchBarComponent(
          hintText: 'Busca tu alimento preferido...',
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: SizedBox(
              height: 100,
              child: CategoriesComponent(),
            ),
          ),
        ),
      ],
    );
  }
}
