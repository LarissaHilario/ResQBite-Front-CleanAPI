import 'package:flutter/material.dart';

import '../../domain/models/product_model.dart';
import '../../infraestructure/repositories/api_product_repository.dart';

class StoreProvider extends ChangeNotifier {
  bool loading = false;
  List<ProductModel> products = [];

  Future<void> getProductsByStore(String token, String storeId) async {
    loading = true;
    notifyListeners();
    try {
      products = await ApiProductRepository().getAllProductsByStore(token, storeId);
    } catch (error) {
      products = [];
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
