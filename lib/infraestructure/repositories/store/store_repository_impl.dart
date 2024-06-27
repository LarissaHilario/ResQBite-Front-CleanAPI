import 'dart:convert';
import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';
import 'package:http/http.dart' as http;

class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<List<StoreModel>> getAllStores(String token) async {
    try {
      final response = await http.get(
          Uri.parse('http://3.223.7.73/stores'),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('stores')) {
          List<dynamic> saucersJson = jsonResponse['stores'];
          return saucersJson.map((saucer) => StoreModel.fromJson(saucer)).toList();
        } else {
          throw Exception('Response does not contain "saucers"');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Error con el servidor: $error');
    }
  }
}
