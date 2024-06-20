import 'package:flutter/material.dart';

class CardOfferComponent extends StatefulWidget {
  const CardOfferComponent({Key? key}) : super(key: key);


  @override
  State<CardOfferComponent> createState() => _CardOfferComponentState();
}

class _CardOfferComponentState extends State<CardOfferComponent> {

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
          // Imagen
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/pancito.png',
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            bottom: 35,
            left: 10,
            right: 0,
            child: Text(
              'Cuernito 5',
              style: TextStyle(
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
                onPressed: () {},
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
