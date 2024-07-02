import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/infraestructure/repositories/api_product_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/store_repository.dart';
import '../../infraestructure/repositories/product_repository_impl.dart';
import '../../infraestructure/repositories/store/store_repository_impl.dart';


class ProductProvider extends ChangeNotifier {
  final ProductRepository _productRepository = ApiProductRepository();
  final StoreRepository _storeRepository = StoreRepositoryImpl();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  List<ProductModel> _productsFiltered = [];
  List<ProductModel> get productsFiltered => _productsFiltered;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> getAllProducts(String token) async {
    _loading = true;
    notifyListeners();
    try {
      List<ProductModel> products = await _productRepository.getAllProducts(token);
      _products = products;
    } catch (error) {
      print('Error al obtener productos: $error');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getAllProductsByCategory(String token, String category) async {
    _loading = true;
    notifyListeners(); // Notificar cambios en la propiedad loading

    try {
      List<ProductModel> products = await _productRepository.getAllProducts(token);
      _productsFiltered = await _filterProducts(products, category, token);
    } catch (error) {
      print('Error al filtrar productos: $error');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<List<ProductModel>> _filterProducts(List<ProductModel> listProducts, String category, String token) async {
    List<ProductModel> filteredProducts = listProducts
        .where((product) => product.category.toUpperCase() == category.toUpperCase())
        .toList();
    for (var product in filteredProducts) {
      if (product.storeId != null) {
        try {
          StoreModel store = await _storeRepository.getStoreById(token, product.storeId!);
          product.storeName = store.name;
        } catch (error) {
          print('Error al obtener el nombre de la tienda: $error');
        }
      }
    }
    return filteredProducts;
  }
}
