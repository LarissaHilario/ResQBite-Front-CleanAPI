import 'dart:io';
import 'package:crud_r/domain/models/store_model.dart';

abstract class StoreRepository {
  Future<List<StoreModel>> getAllStores(String token);
  Future<StoreModel> getStoreById(String token, String storeId);
  Future<void> createStore({
    required String name,
    required String rfc,
    required File image,
    required String street,
    required String number,
    required String neighborhood,
    required String reference,
    required String phone,
    required String city,
    required String openingTime,
    required String closingTime,
    required String token,
  });
}
