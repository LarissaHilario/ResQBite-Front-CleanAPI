import 'package:crud_r/presentation/pages/admin/home_page.dart';
import 'package:crud_r/presentation/providers/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/product_model.dart';
import '../../../domain/use_cases/get_all_product_byStore_usecase.dart';
import '../../../domain/use_cases/get_product_by_id_usecase.dart';
import '../../components/dialog_create_product.dart';
import '../../components/dialog_delete_product.dart';
import '../../components/dialog_update_product.dart';
import '../../components/product_card_page.dart';
import '../../providers/user_provider.dart';


class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}
class _UserPageState extends State<UserPage> {
  late Future<List<ProductModel>> futureProducts;
  late ConnectivityStatus _connectivityStatus;

  @override
  void initState() {
    super.initState();
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token != null) {
      final getAllProductsUseCase = Provider.of<GetAllProductsByStoreUseCase>(context, listen: false);
      //futureProducts = getAllProductsUseCase.execute(token);
    } else {
      futureProducts = Future.error('User is not authenticated');
    }
    final connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    _connectivityStatus = connectivityService.status;
    connectivityService.addListener(_updateConnectivityStatus);
  }
  @override
  void dispose() {
    final connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    connectivityService.removeListener(_updateConnectivityStatus);
    super.dispose();
  }

  void _updateConnectivityStatus() {
    final connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    setState(() {
      _connectivityStatus = connectivityService.status;
    });
  }

  Future<void> _showDeleteDialog(int productId) async {
    try {
      final token =
          Provider.of<UserProvider>(context, listen: false).user?.token;
      final getProductByIdUseCase = Provider.of<GetProductByIdUseCase>(context, listen: false);
      final product = await getProductByIdUseCase.execute(productId, token!);
      showDialog(
        context: context,
        builder: (context) => MyDialogDeleteProduct(
          productId: productId,
          product: product,
        ),
      );
    } catch (error) {
      print('Error al obtener los datos del producto: $error');
    }
  }

  void addProductAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyDialogAddProduct();
      },
    );
  }

  Future<void> _showUpdateDialog(int productId) async {
    try {
      final token = Provider.of<UserProvider>(context, listen: false).user?.token;
      showDialog(
        context: context,
        builder: (context) => MyDialogUpdateProduct(
          productId: productId,
        ),
      );
    } catch (error) {
      print('Error al obtener los datos del producto: $error');
    }
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
                padding: const EdgeInsets.only(left: 29, top: 80, right: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 560),
                child: Container(
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDDE4D9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/user1.svg',
                            width: 40,
                            height: 40,
                          ),
                          onPressed: () {

                            // Navigate to user profile
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/home.svg',
                            width: 45,
                            height: 45,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),
                            );
                            // Navigate to user profile
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/location.svg',
                            width: 50,
                            height: 50,
                          ),
                          onPressed: () {
                            // Navigate to location
                          },
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
