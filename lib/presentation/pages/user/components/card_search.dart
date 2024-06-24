import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final String tienda, producto;
  final ImageProvider? imageProvider;
  final int stock;
  final double price;

  const SearchCard({
    super.key,
    required this.tienda,
    required this.producto,
    this.imageProvider,
    required this.stock,
    required this.price,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  color: Color(0xFF88B04F)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.06,
                    right: MediaQuery.of(context).size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      producto.toUpperCase(),
                      style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(tienda,
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Stock $stock',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(
                          width: 40,
                        ),
                        Text('\$$price',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                  ],
                ),
              )),
          const SizedBox(
            width: 8,
          ),
          Container(
              width: 110,

              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Image.asset(
                'assets/images/searchImg.png',

              ))
        ],
      ),
    );
  }
}
