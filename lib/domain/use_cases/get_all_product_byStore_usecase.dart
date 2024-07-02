import 'package:crud_r/domain/models/product_model.dart';
import 'package:crud_r/domain/repositories/product_repository.dart';

class GetAllProductsByStoreUseCase {
  final ProductRepository _productRepository;

  GetAllProductsByStoreUseCase(this._productRepository);

  Future<List<ProductModel>> execute(String token) async {
    return await _productRepository.getAllProductsByStore(token);
  }
}
