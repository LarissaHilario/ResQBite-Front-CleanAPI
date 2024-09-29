import 'dart:io';

import 'package:crud_r/domain/repositories/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  Future<void> execute(
      {required String name,
      required String description,
      required String price,
      required String stock,
      required String category,
      required String creationDate,
      required String formDescription,
      required String expirationDate,
      required String quality,
      required String manipulation,
      required File image,
      required String storeId,
      required String token}) {
    return productRepository.createProduct(
        name: name,
        description: description,
        price: price,
        stock: stock,
        image: image,
        category: category,
        creationDate: creationDate,
        expirationDate: expirationDate,
        formDescription: formDescription,
        quality: quality,
        manipulation: manipulation,
        storeId: storeId,
        token: token);
  }
}
