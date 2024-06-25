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

  ProductModel({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
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

  };

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
      category: json['category'],

    );
  }

  ImageProvider _getImageProvider() {
    final bytes = base64Decode(image);
    return MemoryImage(bytes);
  }
}
