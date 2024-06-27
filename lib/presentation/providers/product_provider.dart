import 'package:crud_r/infraestructure/repositories/api_product_repository.dart';
import 'package:flutter/material.dart';

import '../../domain/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';
import '../../infraestructure/repositories/product_repository_impl.dart';


class ProductProvider extends ChangeNotifier {
  final ProductRepository _productRepository = ApiProductRepository();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  List<ProductModel> _productsFiltered = [];
  List<ProductModel> get productsFiltered => _productsFiltered;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> getAllProducts(String token) async {
    _loading = true;
    List<ProductModel> products = await _productRepository.getAllProducts(token);
    _products = products;
    print(products);
    _loading = false;
    notifyListeners();
  }

  Future<void> getAllProductsByCategory(String token, String category) async {
    _loading = true;
    List<ProductModel> products = await _productRepository.getAllProducts(token);
    print('Filtrando productos por la categoria $category');
    _productsFiltered = _filterProducts(products, category);
    print(_productsFiltered);
    _loading = false;
    notifyListeners();
  }


  List<ProductModel> _filterProducts(List<ProductModel> listProducts , String category) {
    List<ProductModel> filteredProducts = listProducts
          .where((product) => product.category.toUpperCase() == category.toUpperCase())
          .toList();
    return filteredProducts;
  }
}
