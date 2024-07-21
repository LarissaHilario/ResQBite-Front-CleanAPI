import 'package:crud_r/presentation/pages/user/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/product_model.dart';
import '../../../domain/use_cases/get_all_products_usecase.dart';
import '../../components/categories.dart';
import '../../components/search_bar.dart';
import '../../providers/Wait_provider.dart';
import '../../providers/user_provider.dart';
import '../splash_page.dart';
import 'components/dialog_location.dart';
import 'components/offer_card.dart';
import 'components/store_card.dart';

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({super.key});

  @override
  State<HomeUserPage> createState() => _HomeUserPageState();
}

class _HomeUserPageState extends State<HomeUserPage> {
  late WaitProvider _waitController;
  late Future<List<ProductModel>> _productsFuture;

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
    _productsFuture = _fetchProducts();
  }

  Future<List<ProductModel>> _fetchProducts() async {
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token != null) {
      final getAllProductsUseCase =
          Provider.of<GetAllProductsUseCase>(context, listen: false);
      return await getAllProductsUseCase.execute(token);
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    final userEmail = userProvider.user?.email ?? '';
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTap: () {
                          if (token != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    token: token,
                                    userEmail: userEmail,
                                  ),
                                ));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SearchBarComponent( hintText: 'Busca tu alimento preferido...',),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: SizedBox(height: 100, child: CategoriesComponent()),
                ),
              ),
              const SizedBox(height: 10),
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
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder<List<ProductModel>>(
                            future: _productsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No products available'));
                              } else {
                                final products =
                                    snapshot.data!.take(5).toList();
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    final product = products[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child:
                                          CardOfferComponent(product: product),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: const CardStoreComponent(),
              ),
            ],
          );
        },
      ),
    );
  }
}
