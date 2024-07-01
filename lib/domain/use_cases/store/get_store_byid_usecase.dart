import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';

class GetStoreByIdUseCase {
  final StoreRepository storeRepository;

  GetStoreByIdUseCase(this.storeRepository);

  Future<StoreModel> execute(String token, int storeId) {
    return storeRepository.getStoreById(token, storeId);
  }
}
