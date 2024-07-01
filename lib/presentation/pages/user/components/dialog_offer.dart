import 'package:crud_r/domain/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../domain/use_cases/get_product_by_id_usecase.dart';
import '../../../providers/user_provider.dart';

class MyDialogOfferProduct extends StatefulWidget {
  final int productId;

  const MyDialogOfferProduct({
    Key? key,
    required this.productId,
  }) : super(key: key);

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
      insetPadding: EdgeInsets.all(10),
      content: FutureBuilder<ProductModel>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading product: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final product = snapshot.data!;
            return SizedBox(
              height: 430,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80, top: 5),
                      child: Row(
                        children: [
                          const Text(
                            'OFERTA',
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
                              padding: const EdgeInsets.only(left: 45),
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    ),

                    child:
                    Container(
                      width: double.infinity,
                      child:
                      Image(
                        image: product.imageProvider,

                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    )

                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF88B04F).withOpacity(0.7),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: double.infinity,
                    height: 200,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FiraSansCondensed',
                            letterSpacing: 5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ' \$${product.price}',
                          style: const TextStyle(
                            fontSize: 19.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FiraSansCondensed',
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Disponible: ${product.stock}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'FiraSansCondensed',
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'FiraSansCondensed',
                          ),
                        ),
                        const SizedBox(height: 10),

                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Product not found'));
          }
        },
      ),
    );
  }
}
