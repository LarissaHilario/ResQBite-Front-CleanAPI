import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';

class GetAllStoresUseCase {
  final StoreRepository _storeRepository;
  GetAllStoresUseCase(this._storeRepository);

  Future<List<StoreModel>> getAllStores(String token) async {
    return await _storeRepository.getAllStores(token);
  }
}