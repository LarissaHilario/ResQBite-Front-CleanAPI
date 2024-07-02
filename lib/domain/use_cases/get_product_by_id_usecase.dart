import 'package:crud_r/domain/models/product_model.dart';
import 'package:crud_r/domain/repositories/product_repository.dart';

import '../../infraestructure/repositories/store/store_repository_impl.dart';
import '../models/store_model.dart';
import '../repositories/store_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _productRepository;
  final StoreRepository _storeRepository = StoreRepositoryImpl();

  GetProductByIdUseCase(this._productRepository);

  Future<ProductModel> execute(int productId, String token) async {
    try {
      final product = await _productRepository.getProductById(productId, token);
      StoreModel store = await _storeRepository.getStoreById(token, product.storeId!);
      product.storeName = store.name;
      return product;
    } catch (error) {
      throw Exception('Error al obtener los datos del producto: $error');
    }
  }
}
