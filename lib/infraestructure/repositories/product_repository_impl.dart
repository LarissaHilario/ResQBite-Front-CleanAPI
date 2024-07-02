import 'dart:convert';
import 'dart:io';
import 'package:crud_r/domain/models/product_model.dart';
import 'package:crud_r/domain/repositories/product_repository.dart';
import 'package:crud_r/infraestructure/repositories/api_product_repository.dart';
import 'package:crud_r/infraestructure/repositories/local_product_repository.dart';
import 'package:crud_r/presentation/providers/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class ProductRepositoryImpl extends ChangeNotifier implements ProductRepository {
  final ApiProductRepository _apiProductRepository;
  final LocalProductRepository _localProductRepository;
  final BuildContext context;


  ProductRepositoryImpl(
      this._apiProductRepository,
      this._localProductRepository, this.context,
      );

  @override
  Future<List<ProductModel>> getAllProductsByStore(String token) async {
    var connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      print('tengo internet');
      await _localProductRepository.processPendingOperations(_apiProductRepository, token);
      final products = await _apiProductRepository.getAllProductsByStore(token);
      await _localProductRepository.saveProductsLocally(products);
      return products;
    } else {
      print('No tengo internet');
      final localProducts = await _localProductRepository.getAllProducts();
      return localProducts;
    }
  }

  @override
  Future<ProductModel> getProductById(int productId, String token) async {
    return _apiProductRepository.getProductById(productId, token);

  }

  @override
  Future<void> deleteProduct(String token, int productId) async {
    var connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      print('tengo internet');
      await _localProductRepository.processPendingOperations(_apiProductRepository, token);
      await _apiProductRepository.deleteProduct(token, productId);
    } else {
      print('no tengo internet');
      await _localProductRepository.deleteProductLocally(productId);
      final operation = {'action': 'delete', 'token': token, 'productId': productId};
      await _localProductRepository.savePendingOperation(operation);
    }
  }

  @override
  Future<void> createProduct({
    required String name,
    required String description,
    required String price,
    required String stock,
    required File image,
    required String token,
  }) async {
    var connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      print('tengo internet');
      await _localProductRepository.processPendingOperations(_apiProductRepository, token);
      await _apiProductRepository.createProduct(
        name: name,
        description: description,
        price: price,
        stock: stock,
        image: image,
        token: token,
      );
    } else {
      print('no tengo internet');
      final operation = {
        'action': 'create',
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'image': image.path,
        'token': token,
        'category': 'comida'
      };
      await _localProductRepository.savePendingOperation(operation);
    }
  }

  @override
  Future<void> updateProduct({
    required int productId,
    required String name,
    required String description,
    required String price,
    required String stock,
    required File image,
    required String token,
  }) async {
    var connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      await _localProductRepository.processPendingOperations(_apiProductRepository, token);
      await _apiProductRepository.updateProduct(
        productId: productId,
        name: name,
        description: description,
        price: price,
        stock: stock,
        image: image,
        token: token,
      );
    } else {
      final operation = {
        'action': 'update',
        'productId': productId,
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        'image': image.path,
        'token': token,
      };
      await _localProductRepository.savePendingOperation(operation);
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts(String token) async {
    var connectivityService = Provider.of<ConnectivityService>(context, listen: false);
    if (connectivityService.status == ConnectivityStatus.connected) {
      print('tengo internet');
      final products = await _apiProductRepository.getAllProducts(token);
      await _localProductRepository.saveProductsLocally(products);
      return products;
    } else {
      print('No tengo internet');
      final localProducts = await _localProductRepository.getAllProducts();
      return localProducts;
    }
  }
}
