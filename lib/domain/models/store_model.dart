import 'dart:convert';
import 'package:crud_r/domain/models/product_model.dart';
import 'package:flutter/material.dart';

class StoreModel {
  final String address;
  final String id;
  final String image;
  final String location;
  final String name;
  late ImageProvider imageProvider;
  final String phone;
  late final List<ProductModel> saucers;

  StoreModel({
    required this.address,
    required this.id,
    required this.image,
    required this.location,
    required this.name,
    required this.phone,
    List<ProductModel>? saucers,
  }) : saucers = saucers ?? [] {
    imageProvider = _getImageProvider();
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'id': id,
    'image': image,
    'location': location,
    'name': name,
    'phone': phone,
    'saucers': saucers.map((saucer) => saucer.toJson()).toList(),
  };

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      address: json['address'],
      id: json['id'],
      image: json['image'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],
      saucers: (json['saucers'] as List<dynamic>?)
          ?.map((saucerJson) => ProductModel.fromJson(saucerJson))
          .toList() ?? [],
    );
  }

  ImageProvider _getImageProvider() {
    final bytes = base64Decode(image);
    return MemoryImage(bytes);
  }
}
