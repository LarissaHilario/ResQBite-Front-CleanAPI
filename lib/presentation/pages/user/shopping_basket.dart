import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/basketProvider.dart';
import 'components/basket_card.dart';

class ShoppingBasketPage extends StatefulWidget {
  const ShoppingBasketPage({super.key});

  @override
  State<ShoppingBasketPage> createState() => _ShoppingBasketPageState();
}

class _ShoppingBasketPageState extends State<ShoppingBasketPage> {
  @override
  Widget build(BuildContext context) {
    final basketItems = context.watch<BasketProvider>().basketItems;

    double subtotal = basketItems.fold(0.0, (sum, item) => sum + (item['product'].price * item['quantity']));
    double total = subtotal; // Adjust if needed for taxes or discounts

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 60, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF88B04F).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/arrow-left.svg',
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Text(
                      'Cesta de compras',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 1,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/cesta-black.svg',
                          width: 50,
                          height: 50,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            BasketCard(
              items: basketItems,
            ),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, top: 40, right: 25),
                  child: Text(
                    'Subtotal................................\$12.00',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF464646),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FiraSansCondensed',
                      letterSpacing: 1,
                    ),
                  ),
                )),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, top: 10, right: 25),
                  child: Text(
                    'Total......................................\$12-00}',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF464646),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FiraSansCondensed',
                      letterSpacing: 1,
                    ),
                  ),
                )),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF88B04F),
                    minimumSize: const Size(330, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'PAGAR',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'FiraSansCondensed',
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
