import 'package:crud_r/presentation/components/categories.dart';
import 'package:crud_r/presentation/components/search_bar.dart';
import 'package:crud_r/presentation/pages/user/components/card_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileStorePage()),
                      );*/
                  },
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset(
                      'assets/images/bag.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileStorePage()),
                      );*/
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
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SearchBarComponent(),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child:
              Container(height: 100, child: const CategoriesComponent()),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: SearchCard(
                    tienda: 'Pastelería sofía',
                    producto: 'Paquete de 4 donas',
                    stock: 5,
                    price: 30.0,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
