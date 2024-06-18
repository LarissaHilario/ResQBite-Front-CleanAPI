import 'package:crud_r/presentation/components/categories.dart';
import 'package:crud_r/presentation/components/search_bar.dart';
import 'package:crud_r/presentation/pages/user/components/offer_card.dart';
import 'package:crud_r/presentation/pages/user/components/dialog_location.dart';
import 'package:crud_r/presentation/providers/Wait_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WaitProvider _waitController;

  Future<void> _checkAndShowAlert() async {
    bool isLocationPermissionGranted = await _waitController.checkPermission();

    if (!isLocationPermissionGranted) {
      Future.delayed(const Duration(seconds: 3), () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const DialogLocation();
          },
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _waitController = WaitProvider(Permission.location);
    _checkAndShowAlert();
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
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF88B04F).withOpacity(.21),
                    ),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 25, top: 10),
                              child: Text(
                                'OFERTAS',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Color(0xFF464646),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 3,
                                ),
                              ),
                            )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (BuildContext context, int index) {
                                return const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CardOfferComponent(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 35, top: 15),
                        child: Text(
                          'Tiendas',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFF464646),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'FiraSansCondensed',
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, right: 20),
                        child: Container(
                          height: 240,
                          child: GridView.count(
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 2, // Dos columnas
                            children: List.generate(6, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 140,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xFF88B04F)
                                        .withOpacity(.85),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Imagen
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: Image.asset(
                                          'assets/images/tienda-sofi.png',
                                          width: 140,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      const Positioned(
                                        bottom: 35,
                                        left: 10,
                                        right: 0,
                                        child: Text(
                                          'Pastelería Sofi',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 2.5,
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              minimumSize: Size(8, 20),
                                            ),
                                            child: const Text(
                                              'Ver más',
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Color(0xFF88B04F),
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'FiraSansCondensed',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDE4D9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/store.svg',
                            width: 50,
                            height: 50,
                          ),
                          onPressed: () {
                            /* Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeAdmiPage()),
                            );*/
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/home.svg',
                            width: 50,
                            height: 50,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/location.svg',
                            width: 50,
                            height: 50,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
