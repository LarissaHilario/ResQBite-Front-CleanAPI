import 'package:crud_r/domain/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../domain/use_cases/get_product_by_id_usecase.dart';
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

  void closeAlert() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(8),
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
              height: 530,
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
                    child: Container(
                      width: double.infinity,
                      child: Image(
                        image: product.imageProvider,
                        height: 160,
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
                                padding: EdgeInsets.only(top: 3),
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

                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 5),
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
                            padding: EdgeInsets.only(top: 10, left: 10),
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
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 11),
                            child: Text(
                              product.description,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'FiraSansCondensed',
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [

                            const SizedBox(
                              width: 20,
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: 11),
                                child: Text(
                                  'Disponible :  ${product.stock}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FiraSansCondensed',
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 11),
                            child: Text(
                              product.description,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'FiraSansCondensed',
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 11, left: 11),
                            child: Text(
                              'Fecha de vencimiento: ',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FiraSansCondensed',
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                  'assets/images/minus.svg',
                                  height: 25,
                                ),
                                onPressed: () {},
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                  'assets/images/more.svg',
                                  height: 25,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          width: 155,
                          height: 36,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: SvgPicture.asset(
                                  'assets/images/cesta.svg',
                                  height: 22,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                                ),
                                child: const Text(
                                  'Añadir a la cesta',
                                  style: TextStyle(
                                    color: Color(0xFF88B04F),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ]
                    )
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
