import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';
import 'package:crud_r/infraestructure/repositories/store/store_repository_impl.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/product_model.dart';
import '../../../infraestructure/repositories/api_product_repository.dart';

class StoreProvider extends ChangeNotifier {
  final StoreRepository _storeRepository = StoreRepositoryImpl();
  String? _storeId;

  List<StoreModel> _stores = [];
  List<StoreModel> get stores => _stores;

  late StoreModel _store;
  StoreModel get store => _store;

  bool _loading = false;
  bool get loading => _loading;

  void getAllStores(String token) async {
    _loading = true;
    List<StoreModel> stores = await _storeRepository.getAllStores(token);
    _stores = stores;
    _loading = false;
    notifyListeners();
  }

  Future<StoreModel> getStoreById(String token, String storeId) async {
    _loading = true;
    _store = await _storeRepository.getStoreById(token, storeId);
    _loading = false;

    notifyListeners();
    return _store;
  }

  List<ProductModel> products = [];

  Future<void> getProductsByStore(String token, String storeId) async {
    _loading = true;
    notifyListeners();
    try {
      products = await ApiProductRepository().getAllProductsByStore(token, storeId);
    } catch (error) {
      products = [];
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
