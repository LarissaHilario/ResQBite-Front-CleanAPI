import 'package:crud_r/presentation/pages/user/components/dialog_offer.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/product_model.dart';

class CardOfferComponent extends StatelessWidget {
  final ProductModel product;
  final void Function()? onDelete;
  final void Function()? onEdit;

  const CardOfferComponent({
    Key? key,
    required this.product,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  void offerDialog(BuildContext context, int productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialogOfferProduct(productId: productId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF88B04F).withOpacity(.85),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image(
              image: product.imageProvider,
              width: 140,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 35,
            left: 10,
            right: 0,
            child: Text(
              '${product.name} \$${product.price}',
              style: const TextStyle(
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
                onPressed: () {
                  offerDialog(context, product.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: const Size(8, 20),
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
    );
  }
}
