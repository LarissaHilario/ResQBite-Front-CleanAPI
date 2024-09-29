import 'dart:convert';
import 'dart:io';
import 'package:crud_r/domain/models/product_model.dart';
import 'package:crud_r/domain/repositories/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProductRepository implements ProductRepository {
  @override
  Future<List<ProductModel>> getAllProductsByStore(String token,
      String storeId) async {
    final response = await http.get(
      Uri.parse(
          'https://resqbite-gateway.integrador.xyz:3000/api/v5/product/products/store/$storeId'),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);

      List<dynamic> saucersJson = jsonResponse;
      return saucersJson.map((saucer) => ProductModel.fromJson(saucer))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<ProductModel> getProductById(int productId, String token) async {
    final response = await http.get(
      Uri.parse(
          'https://resqbite-gateway.integrador.xyz:3000/api/v5/product/products/$productId'),

    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final productData = json.decode(response.body);
      print(productData);
      return ProductModel.fromJson(productData);
    } else {
      throw Exception('Error al obtener los datos del producto');
    }
  }

  @override
  Future<void> deleteProduct(String token, int productId) async {
    final url = 'https://localhost:3000/api/v5/product/products/$productId';
    final response = await http.delete(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      print('Producto eliminado exitosamente');
    } else {
      throw Exception(
          'Error al eliminar el producto: ${response.reasonPhrase}');
    }
  }

  @override
  Future<void> createProduct({required String name,
    required String description,
    required String price,
    required String stock,
    required String category,
    required String creationDate,
    required String formDescription,
    required String expirationDate,
    required String quality,
    required String manipulation,
    required File image,
    required String storeId,
    required String token
  }) async {
    const url = 'https://resqbite-gateway.integrador.xyz:3000/api/v5/product/create-products';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.fields.addAll({
      'name': name,
      'precio': price,
      'quantity': stock,
      'sales_description': description,
      'category': category,
      'form[description]': formDescription,
      'form[creation_date]': creationDate,
      'form[approximate_expiration_date]': expirationDate,
      'form[quality]': quality,
      'form[manipulation]': manipulation,
      'uuid_Store': storeId,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    final response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 308) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        final redirectResponse = await http.get(Uri.parse(redirectUrl));
        print(redirectResponse.statusCode);
        if (redirectResponse.statusCode == 201) {
          if (kDebugMode) {
            print('Producto creado exitosamente');
          }
        } else {
          // Aquí se debería manejar el error con un mensaje adecuado
          final errorResponse = await http.Response.fromStream(response);
          final errorMessage = json.decode(errorResponse.body)['message'];
          throw Exception('Error al crear el producto: $errorMessage');
        }
      } else {
        throw Exception('No se proporcionó una URL de redirección');
      }
    }
    else if (response.statusCode == 201) {
      if (kDebugMode) {
        print('Producto creado exitosamente');
      }
    } else {
      // Aquí se debería manejar el error con un mensaje adecuado
      final errorResponse = await http.Response.fromStream(response);
      final errorMessage = json.decode(errorResponse.body)['message'];
      throw Exception('Error al crear el producto: $errorMessage');
    }
  }

  @override
  Future<void> updateProduct({required int productId,
    required String name,
    required String description,
    required String price,
    required String stock,
    required File image,
    required String token}) async {
    final url = 'https://resqbite-gateway.integrador.xyz:3000/api/v5/product/products/$productId';
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.fields.addAll({
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category': 'comida'
    });
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    final response = await request.send();
    if (response.statusCode == 308) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        final redirectResponse = await http.get(Uri.parse(redirectUrl));
        print(redirectResponse.statusCode);
        if (redirectResponse.statusCode == 200) {
          if (kDebugMode) {
            print('Producto actualizado exitosamente');
          }
        } else {
          // Aquí se debería manejar el error con un mensaje adecuado
          final errorResponse = await http.Response.fromStream(response);
          final errorMessage = json.decode(errorResponse.body)['message'];
          throw Exception('Error al actualizar el producto: $errorMessage');
        }
      } else {
        throw Exception('No se proporcionó una URL de redirección');
      }
    } else if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Producto actualizado exitosamente');
      }
    } else {
      // Aquí se debería manejar el error con un mensaje adecuado
      final errorResponse = await http.Response.fromStream(response);
      final errorMessage = json.decode(errorResponse.body)['message'];
      throw Exception('Error al actualizar el producto: $errorMessage');
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts(String token) async {
    final response = await http.get(
      Uri.parse(
          'https://resqbite-gateway.integrador.xyz:3000/api/v5/product/products'),

    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      print(jsonResponse);
      List<dynamic> saucersJson = jsonResponse;
      return saucersJson.map((saucer) => ProductModel.fromJson(saucer))
          .toList();
    } else {
      throw Exception('Response does not contain "saucers"');
    }
  }
}