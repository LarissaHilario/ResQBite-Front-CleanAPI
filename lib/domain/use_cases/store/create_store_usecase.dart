import 'dart:io';
import 'package:crud_r/domain/repositories/store_repository.dart';

class CreateStoreUseCase {
  final StoreRepository repository;

  CreateStoreUseCase(this.repository);

  Future<void> call({
    required String name,
    required String rfc,
    required String street,
    required String number,
    required String neighborhood,
    required String reference,
    required String phone,
    required String city,
    required String openingTime,
    required String closingTime,
    required File image,
    required String token,
  }) async {
    await repository.createStore(
      name: name,
      rfc: rfc,
      street: street,
      number: number,
      neighborhood: neighborhood,
      reference: reference,
      phone: phone,
      city: city,
      openingTime: openingTime,
      closingTime: closingTime,
      image: image,
      token: token,
    );
  }
}
