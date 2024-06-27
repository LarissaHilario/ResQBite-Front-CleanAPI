import 'package:crud_r/domain/models/store_model.dart';

abstract class StoreRepository {
  //Future<List<ProductModel>> getAllProductsByStore(String token);
  Future<List<StoreModel>> getAllStores(String token);
}