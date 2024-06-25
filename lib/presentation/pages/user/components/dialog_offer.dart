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
    final getProductByIdUseCase =
        Provider.of<GetProductByIdUseCase>(context, listen: false);
    return await getProductByIdUseCase.execute(widget.productId, token!);
  }

  void closeAlert() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        content: SizedBox(
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
                                    color: const Color(0xFF88B04F)
                                        .withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                      'assets/images/close.svg'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Image.asset(
                    'assets/images/cuerno.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF88B04F).withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  width: 500,
                  height: 200,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              'CUERNITO',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'FiraSansCondensed',
                                letterSpacing: 5,
                              ),
                            ),
                          )),
                      Row(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SvgPicture.asset(
                                  'assets/images/ubication-store.svg',
                                  width: 25,
                                ),
                              )),
                          const Text(
                            ' Pastelería Sofi',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'FiraSansCondensed',
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: const Text(
                                  ' \$ 5 Pesos',
                                  style: TextStyle(
                                    fontSize: 19.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FiraSansCondensed',
                                    letterSpacing: 2,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(top: 11),
                                child: const Text(
                                  'Disponible : 2',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'FiraSansCondensed',
                                    letterSpacing: 1,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, left: 10),
                            child: const Text(
                              ' Rico cuernito relleno de chocolate',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'FiraSansCondensed',
                              ),
                            ),
                          )),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, left: 10),
                              child: Container(
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
                                          height: 25, // Ajusta el tamaño según tus necesidades
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
                                          height: 25, // Ajusta el tamaño según tus necesidades
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),


                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  width: 155,
                                  height: 36,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: SvgPicture.asset(

                                            'assets/images/cesta.svg',
                                            height: 22,
                                          )),

                                      TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all(EdgeInsets.all(5)), // Establece el padding a cero
                                         
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
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
