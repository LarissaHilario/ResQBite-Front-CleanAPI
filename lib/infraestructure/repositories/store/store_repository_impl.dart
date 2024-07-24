import 'dart:convert';
import 'dart:io';
import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';
import 'package:http/http.dart' as http;

class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<List<StoreModel>> getAllStores(String token) async {
    try {
      final response = await http.get(
          Uri.parse('https://resqbite-gateway.integrador.xyz:3000/api/v4/store/stores'),
          headers: {'Authorization': 'Bearer $token'});

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        List<dynamic> saucersJson = jsonResponse;
        return saucersJson
            .map((saucer) => StoreModel.fromJson(saucer))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }

  @override
  Future<StoreModel> getStoreById(String token, String storeId) async {
    try {
      final response = await http.get(
        Uri.parse('https://resqbite-gateway.integrador.xyz:3000/api/v4/store/store/$storeId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        StoreModel store = StoreModel.fromJson(jsonResponse);
        return store;
      } else {
        throw Exception('Failed to load store: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error with server: $error');
    }
  }

  @override
  Future<void> createStore({
    required String name,
    required String rfc,
    required File image,
    required String street,
    required String number,
    required String neighborhood,
    required String reference,
    required String phone,
    required String city,
    required String openingTime,
    required String closingTime,
    required String token,
  }) async {
    final url = Uri.parse('https://resqbite-gateway.integrador.xyz:3000/api/v4/store/create-store');
    final request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['rfc'] = rfc;
    request.fields['street'] = street;
    request.fields['number'] = number;
    request.fields['neighborhood'] = neighborhood;
    request.fields['city'] = city;
    request.fields['reference'] = reference;
    request.fields['phone_number'] = phone;
    request.fields['opening_hours'] = openingTime;
    request.fields['closing_hours'] = closingTime;
    request.fields['name'] = name;

    request.files.add(await http.MultipartFile.fromPath('url_image', image.path));

    final response = await request.send();
    print(response.statusCode);

    if (response.statusCode != 201) {
      throw Exception('Failed to create store: ${response.reasonPhrase}');
    } else {
      print('Store created successfully');
    }
  }
}
