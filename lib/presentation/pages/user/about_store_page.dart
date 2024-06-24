import 'package:crud_r/presentation/pages/user/components/card_search.dart';
import 'package:crud_r/presentation/pages/user/components/offer_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoreUserPage extends StatefulWidget {
  const StoreUserPage({Key? key}) : super(key: key);

  @override
  State<StoreUserPage> createState() => _StoreUserPageState();
}

class _StoreUserPageState extends State<StoreUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 205,
          child: Image.asset(
            'assets/images/photo_store.png',
            width: double.infinity,
          ),
        ),
        const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: const Text(
                'Pastelería Sofi',
                style: TextStyle(
                  fontSize: 26.0,
                  color: Color(0xFF464646),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'FiraSansCondensed',
                  letterSpacing: 5,
                ),
              ),
            )),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(children: [
                Row(children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SvgPicture.asset(
                          'assets/images/location_icon.svg',
                          width: 25,
                        ),
                      )),
                  const Text(
                    'Col. Oriente Sur #122',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF464646),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FiraSansCondensed',
                      letterSpacing: 2,
                    ),
                  ),
                ]),
                Row(children: [
                  Row(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, left: 5),
                          child: SvgPicture.asset(
                            'assets/images/clock.svg',
                            width: 18,
                          ),
                        )),
                    const Text(
                      ' 09:00 hrs - 19:00 hrs',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 1,
                      ),
                    ),
                  ]),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1, left: 40),
                        child: SvgPicture.asset(
                          'assets/images/phone.svg',
                          width: 18,
                        ),
                      )),
                  const Text(
                    ' 9514134607',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF464646),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FiraSansCondensed',
                      letterSpacing: 1,
                    ),
                  ),
                ])
              ])),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
        const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 25, top: 10),
              child: Text(
                'Más productos',
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
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.all(2.0),
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

      ]),
    );
  }
}
