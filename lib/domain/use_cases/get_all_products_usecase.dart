
import 'package:crud_r/domain/models/product_model.dart';
import 'package:crud_r/domain/repositories/product_repository.dart';
import 'package:crud_r/domain/use_cases/get_all_product_byStore_usecase.dart';

class GetAllProductsUseCase {
  final ProductRepository _productRepository;

  GetAllProductsUseCase(this._productRepository);

  Future<List<ProductModel>> execute(String token) async {
    return await _productRepository.getAllProducts(token);
  }
}
