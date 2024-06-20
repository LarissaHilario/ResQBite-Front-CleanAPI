import 'package:flutter/material.dart';

class CardStoreComponent extends StatefulWidget {
  const CardStoreComponent({Key? key}) : super(key: key);

  @override
  State<CardStoreComponent> createState() => _CardOfferComponentState();
}

class _CardOfferComponentState extends State<CardStoreComponent> {
  @override
  Widget build(BuildContext context) {
    return Align(
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
                            color: const Color(0xFF88B04F).withOpacity(.85),
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
                                  padding: const EdgeInsets.only(right: 5),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
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
    );
  }
}
