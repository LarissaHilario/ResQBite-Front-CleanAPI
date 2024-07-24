import 'package:crud_r/presentation/pages/user/components/offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/presentation/providers/store/store_provider.dart';
import 'package:crud_r/presentation/providers/user_provider.dart';
import 'components/card_search.dart';

class StoreUserPage extends StatefulWidget {
  final String storeId;

  const StoreUserPage({Key? key, required this.storeId}) : super(key: key);

  @override
  State<StoreUserPage> createState() => _StoreUserPageState();
}

class _StoreUserPageState extends State<StoreUserPage> {
  late Future<void> _storeFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token != null) {
      _storeFuture = _fetchStoreDetails(token, widget.storeId);
    }
  }

  Future<void> _fetchStoreDetails(String token, String storeId) async {
    await Provider.of<StoreProvider>(context, listen: false).getStoreById(token, storeId);
    await Provider.of<StoreProvider>(context, listen: false).getProductsByStore(token, storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
          future: _storeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar los detalles de la tienda'));
            } else {
              final store = Provider.of<StoreProvider>(context).store;
              final products = Provider.of<StoreProvider>(context).products;
              final offerProducts = products.take(5).toList();
              final otherProducts = products.skip(5).toList();

              return Column(
                children: [
                  Container(
                    height: 205,
                    child: Image(image: store.imageProvider, width: double.infinity),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SvgPicture.asset(
                                    'assets/images/location_icon.svg',
                                    width: 25,
                                  ),
                                ),
                              ),
                              Text(
                                '${store.street} #${store.number} col. ${store.neighborhood}, ${store.city}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF464646),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2, left: 5),
                                      child: SvgPicture.asset(
                                        'assets/images/clock.svg',
                                        width: 18,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ' ${store.openingTime} hrs - ${store.closingTime} hrs',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xFF464646),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'FiraSansCondensed',
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1, left: 40),
                                  child: SvgPicture.asset(
                                    'assets/images/phone.svg',
                                    width: 18,
                                  ),
                                ),
                              ),
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
                            ],
                          ),
                        ],
                      ),
                    ),
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
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: offerProducts.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final product = offerProducts[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CardOfferComponent(product: product),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                    ),
                  ),
                  ListView.builder(
                    itemCount: otherProducts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final product = otherProducts[index];
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SearchCard(
                          tienda: store.name,
                          producto: product.name,
                          stock: product.stock,
                          price: product.price,
                          imageProvider: product.imageProvider,
                          id: product.id,
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
