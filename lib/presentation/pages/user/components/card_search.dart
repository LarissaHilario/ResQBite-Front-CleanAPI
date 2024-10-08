import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog_offer.dart';

class SearchCard extends StatelessWidget {
  final String tienda, producto;
  final ImageProvider? imageProvider;
  final int stock;
  final double price;
  final int id;

  const SearchCard({
    super.key,
    required this.tienda,
    required this.producto,
    this.imageProvider,
    required this.stock,
    required this.price,
    required this.id

  });
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

    return

      InkWell(
        onTap: (){
          offerDialog(context, id);
        },


        child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 184,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFF88B04F),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.06,
                  right: MediaQuery.of(context).size.width * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        producto.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Text(
                        tienda,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Stock $stock',
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          '\$$price',
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                width: 110,
                height: 110,
                image: imageProvider ?? const AssetImage('assets/images/donas.png'),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
            ),
      );
  }
}
