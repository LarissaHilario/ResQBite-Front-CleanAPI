import 'dart:convert';
import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String name;
  final int stock;
  final double price;
  final String image;
  final String description;
  late ImageProvider imageProvider;
  final String category;
  final String? storeId;
  String? storeName;
  final String expirationDate;

  ProductModel({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    required this.expirationDate,
    this.storeId,
    this.storeName,
  }) {
    imageProvider = _getImageProvider();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'stock': stock,
    'image': image,
    'category': category,
    'store_id': storeId,
    'expiration_date': expirationDate,
  };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      stock: json['quantity'],
      price: json['precio'].toDouble(),
      image: json['image'],
      description: json['sales_description'],
      category: json['category'],
      storeId: json['uuid_Store'],
      expirationDate: json['form']['approximate_expiration_date'],
    );
  }

  ImageProvider _getImageProvider() {
    if (_isBase64(image)) {
      final bytes = base64Decode(image);
      return MemoryImage(bytes);
    } else {
      return NetworkImage(image);
    }
  }

  bool _isBase64(String str) {
    try {
      base64Decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
