import 'dart:io';

import 'package:crud_r/domain/models/product_model.dart';


abstract class ProductRepository {
  Future<List<ProductModel>> getAllProductsByStore(String token);
  Future<void> deleteProduct(String token, int productId);
  Future<ProductModel> getProductById(int productId, String token);
  Future<void> createProduct({
    required String name,
    required String description,
    required String price,
    required String stock,
    required File image, required String token,
  });
  Future<void> updateProduct({
    required int productId,
    required String name,
    required String description,
    required String price,
    required String stock,
    required File image,
    required String token,
  });
  Future<List<ProductModel>> getAllProducts(String token);
}