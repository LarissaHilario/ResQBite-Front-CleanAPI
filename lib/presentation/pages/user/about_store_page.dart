import 'package:crud_r/domain/use_cases/store/get_store_byid_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:crud_r/domain/models/store_model.dart';

import '../../providers/store/store_provider.dart';
import '../../providers/user_provider.dart';
import 'components/card_search.dart';

class StoreUserPage extends StatefulWidget {
  final int storeId;

  const StoreUserPage({Key? key, required this.storeId}) : super(key: key);

  @override
  State<StoreUserPage> createState() => _StoreUserPageState();
}

class _StoreUserPageState extends State<StoreUserPage> {
  late Future<StoreModel> _storeFuture;

  @override
  void initState() {
    super.initState();
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token != null) {
      _storeFuture = Provider.of<StoreProvider>(context, listen: false)
          .getStoreById(token, widget.storeId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: FutureBuilder<StoreModel>(
        future: _storeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar los detalles de la tienda'));
          } else if (snapshot.hasData) {
            final store = snapshot.data!;
            return Column(children: [
              Container(
                height: 205,

                child: Image(image: store.imageProvider, width: double.infinity,
                ),
              ),
               Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      store.name,
                      style: const TextStyle(
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
                        Text(
                          store.address,
                          style: const TextStyle(
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
                        Text(
                          store.phone,
                          style: const TextStyle(
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
                    padding: EdgeInsets.only(left: 25, top: 20),
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
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
            ]);
          } else {
            return const Center(
                child: Text('No se encontraron detalles de la tienda'));
          }
        },
      ),
    ));
  }
}
