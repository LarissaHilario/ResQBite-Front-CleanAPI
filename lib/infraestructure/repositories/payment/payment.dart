import 'dart:convert';
import 'package:http/http.dart' as http;

Future createPaymentIntent({
  required String name,
  required String city,
  required String state,
  required String country,
  required String currency,
  required String amount,
  required String description
}) async {
  final url = Uri.parse('https://resqbite-payment.integrador.xyz:4242/create-payment-intent'); // Cambia esto a la URL de tu API en producción
  final body = json.encode({
    'amount': (int.parse(amount)*100).toString(), // Stripe requiere el monto en la menor unidad de la moneda
    'currency': currency,
    'name': name,
    'description': description,
    'city': city,
    'state': state,
    'country': country
  });

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );
  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['client_secret'];
  } else {
    throw Exception('Failed to create payment intent');
  }
}
