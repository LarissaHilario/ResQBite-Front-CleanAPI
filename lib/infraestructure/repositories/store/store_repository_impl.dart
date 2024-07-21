import 'dart:convert';
import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';
import 'package:http/http.dart' as http;

class StoreRepositoryImpl implements StoreRepository {
  @override
  Future<List<StoreModel>> getAllStores(String token) async {
  try {
  final response = await http.get(
  Uri.parse('http://3.229.72.193:3000/api/v4/store/stores'),
  headers: {'Authorization': 'Bearer $token'});
  print(response.statusCode);
  if (response.statusCode == 200) {
  final dynamic jsonResponse = json.decode(response.body);

  List<dynamic> saucersJson = jsonResponse;
  return saucersJson.map((saucer) => StoreModel.fromJson(saucer)).toList();

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
        Uri.parse('http://3.223.7.73/store/$storeId'),
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
}
