import 'dart:convert';
import 'dart:io';
import 'package:crud_r/domain/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_product_repository.dart';

class LocalProductRepository {
  static const String _pendingOperationsKey = 'pending_operations';

  Future<void> processPendingOperations(ApiProductRepository apiProductRepository, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final pendingOperations = prefs.getStringList(_pendingOperationsKey);
    print(pendingOperations);
    print('HOLAaaaaaaaa');
    if (pendingOperations != null) {
      for (final operationJson in pendingOperations) {
        final operation = json.decode(operationJson);
        final action = operation['action'];
        print(operation);
       if (action == 'update') {
          final productId = operation['productId'];
          final name = operation['name'];
          final description = operation['description'];
          final price = operation['price'];
          final stock = operation['stock'];
          final image = File(operation['image']);
          await apiProductRepository.updateProduct(
            productId: productId,
            name: name,
            description: description,
            price: price,
            stock: stock,
            image: image,
            token: token,
          );
        } else if (action == 'delete') {
          final productId = operation['productId'];
          await apiProductRepository.deleteProduct(token, productId);
        }
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print("SharedPreferences cleared");
    }
  }

  Future<void> savePendingOperation(Map<String, dynamic> operation) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> pendingOperations = prefs.getStringList(_pendingOperationsKey) ?? [];
    pendingOperations.add(json.encode(operation));
    await prefs.setStringList(_pendingOperationsKey, pendingOperations);
    print('Pending operation saved: $operation');
  }

  Future<List> getPendingOperations() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? pendingOperations = prefs.getStringList(_pendingOperationsKey);
    if (pendingOperations != null) {
      print('Pending operation saved: $pendingOperations.map((operation) => json.decode(operation)).toList()');
      return pendingOperations.map((operation) => json.decode(operation)).toList();

    } else {
      return [];
    }
  }

  Future<List<ProductModel>> getAllProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? productsStringList = prefs.getStringList('products');
    if (productsStringList != null) {
      print("Retrieved products locally: $productsStringList");
      final List<ProductModel> products = productsStringList.map((productString) {
        final Map<String, dynamic> productJson = json.decode(productString);
        print(ProductModel.fromJson(productJson));
        return ProductModel.fromJson(productJson);
      }).toList();
      return products;
    } else {
      print('no hay nada');
      return [];
    }
  }
  Future<void> createProductLocally(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsString = prefs.getString('products');
    if (productsString != null) {
      final List<dynamic> productsJson = json.decode(productsString);
      productsJson.add(product.toJson());
      final updatedProductsJson = productsJson.map((product) => json.encode(product)).toList();
      await prefs.setStringList('products', updatedProductsJson);
    }
  }

  Future<void> saveProductsLocally(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productsJson = products.map((product) => json.encode(product.toJson())).toList();
    await prefs.setStringList('products', productsJson);
    print("Products saved locally: $productsJson");
  }

  Future<void> deleteProductLocally(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? productsStringList = prefs.getStringList('products');

    if (productsStringList != null) {
      final List<Map<String, dynamic>> productsJson =
      productsStringList.map((productString) {
        return json.decode(productString) as Map<String, dynamic>;
      }).toList();

      final List<Map<String, dynamic>> updatedProducts =
      productsJson.where((product) {
        return product['id'] != productId;
      }).toList();

      final List<String> updatedProductsJson =
      updatedProducts.map((product) => json.encode(product)).toList();

      await prefs.setStringList('products', updatedProductsJson);
      print('Product deleted locally');
    }
  }


  Future<void> updateProductLocally(ProductModel updatedProduct) async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsString = prefs.getString('products');
    if (productsString != null) {
      final List<dynamic> productsJson = json.decode(productsString);
      final updatedProducts = productsJson.map((product) {
        if (product['id'] == updatedProduct.id) {
          return updatedProduct.toJson();
        }
        return product;
      }).toList();
      final updatedProductsJson = updatedProducts.map((product) => json.encode(product)).toList();
      await prefs.setStringList('products', updatedProductsJson);
    }
  }
  Future<ProductModel> getProductById(int productId, String token) async {
    final prefs = await SharedPreferences.getInstance();
    final productsString = prefs.getString('products');
    if (productsString != null) {
      final List<dynamic> productsJson = json.decode(productsString);
      final productJson = productsJson.firstWhere(
            (productJson) => productJson['id'] == productId,
        orElse: () => throw Exception('Product not found locally'),
      );
      return ProductModel.fromJson(productJson);
    } else {
      throw Exception('No cached products available');
    }
  }
}
