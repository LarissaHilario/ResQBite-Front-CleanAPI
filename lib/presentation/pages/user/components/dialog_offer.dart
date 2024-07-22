import 'dart:convert';
import 'package:crud_r/domain/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../domain/use_cases/get_product_by_id_usecase.dart';
import '../../../providers/basketProvider.dart';
import '../../../providers/user_provider.dart';

class MyDialogOfferProduct extends StatefulWidget {
  final int productId;

  const MyDialogOfferProduct({
    super.key,
    required this.productId,
  });

  @override
  _MyDialogOfferProductState createState() => _MyDialogOfferProductState();
}

class _MyDialogOfferProductState extends State<MyDialogOfferProduct> {
  late Future<ProductModel> _productFuture;
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _productFuture = _fetchProductData();
  }

  Future<ProductModel> _fetchProductData() async {
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token == null) {
      throw Exception('Token is null');
    }
    final getProductByIdUseCase =
    Provider.of<GetProductByIdUseCase>(context, listen: false);
    return await getProductByIdUseCase.execute(widget.productId, token);
  }

  void _incrementQuantity(ProductModel product) {
    setState(() {
      if (_quantity < product.stock) {
        _quantity++;
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
      }
    });
  }

  void _addToBasket(ProductModel product) {
    if (_quantity > 0) {
      final basketProvider = Provider.of<BasketProvider>(context, listen: false);
      basketProvider.addItem(product, _quantity);
      Navigator.pop(context, {
        'product': product,
        'quantity': _quantity,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No puedes agregar 0 unidades a la cesta de compras.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: FutureBuilder<ProductModel>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading product: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return SizedBox(
              height: 540,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80, top: 8),
                      child: Row(
                        children: [
                          const Text(
                            'DETALLES',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Color(0xFF464646),
                              fontWeight: FontWeight.w300,
                              fontFamily: 'FiraSansCondensed',
                              letterSpacing: 5,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFF88B04F).withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset('assets/images/close.svg'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Image(
                        image: product.imageProvider,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 23.0,
                                  color: Color(0xFF88B04F),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                ' \$${product.price}',
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  color: Color(0xFF88B04F),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SvgPicture.asset(
                                'assets/images/ubication-store.svg',
                                width: 30,
                              ),
                            ),
                          ),
                          Text(
                            product.storeName ?? 'Cargando...',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'FiraSansCondensed',
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, left: 4),
                          child: Text(
                            'Descripción',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FiraSansCondensed',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, left: 4),
                          child: Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'FiraSansCondensed',
                            ),
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, left: 4),
                          child: Text(
                            'Fecha de vencimiento',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FiraSansCondensed',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4, top: 5),
                              child: SvgPicture.asset(
                                'assets/images/date.svg',
                                width: 30,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 11, left: 10),
                              child: Text(
                                product.expirationDate,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 11, left: 4),
                          child: Text(
                            '${product.stock} piezas',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black45,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'FiraSansCondensed',
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 130,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: const Color(0xFF88B04F),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: SvgPicture.asset(
                                    'assets/images/minus.svg',
                                    height: 30,
                                  ),
                                  onPressed: _decrementQuantity,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Text(
                                    '$_quantity',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: SvgPicture.asset(
                                    'assets/images/more.svg',
                                    height: 30,
                                  ),
                                  onPressed: () => _incrementQuantity(product),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF88B04F),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            width: 160,
                            height: 36,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: SvgPicture.asset(
                                    'assets/images/cesta-white.svg',
                                    height: 22,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => _addToBasket(product),
                                  style: ButtonStyle(
                                    padding: WidgetStateProperty.all(const EdgeInsets.all(5)),
                                  ),
                                  child: const Text(
                                    'Añadir a la cesta',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No product data available'));
          }
        },
      ),
    );
  }
}
