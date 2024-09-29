import 'package:crud_r/infraestructure/repositories/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
  String selectedCurrency = 'USD';
  String amount = '0';
  String description = 'Suscription';

  bool hasDonated = false;
  Future<void> initPaymentSheet() async {
    try {
      final clientSecret = await createPaymentIntent(
        amount: amount,
        currency: selectedCurrency,
        description: 'pago',
        name: 'larissa',
        city: 'oaxaca',
        state: 'oaxaca',
        country: 'mexico',
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Test',
          style: ThemeMode.system,
        ),
      );
    } catch (e) {
      print('Error initializing payment sheet: $e');
    }
  }

  Future<void> _handlePayment() async {
    await initPaymentSheet();

    try {
      await Stripe.instance.presentPaymentSheet();
      context.read<BasketProvider>().clearBasket();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Pago realizado",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Oops ocurrió un fallo en el pago");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Oops ocurrió un fallo en el pago",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final basketItems = context.watch<BasketProvider>().basketItems;

    double subtotal = basketItems.fold(0.0, (sum, item) => sum + (item['product'].price * item['quantity']));
    double total = subtotal;
    amount = (total * 1).toStringAsFixed(0);
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
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 40, right: 25),
                  child: Text(
                    'Subtotal................................\$${subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFF464646),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'FiraSansCondensed',
                      letterSpacing: 1,
                    ),
                  ),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
                  child: Text(
                    'Total......................................\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
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
                  onPressed: () async {
                    await _handlePayment();
                  },
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
