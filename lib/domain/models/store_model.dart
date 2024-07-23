import 'dart:convert';
import 'package:crud_r/domain/models/product_model.dart';
import 'package:flutter/material.dart';

class StoreModel {
  final String closingTime;
  final String openingTime;
  final String neighborhood;
  final String number;
  final String id;
  final String image;
  final String city;
  final String name;
  late ImageProvider imageProvider;
  final String phone;
  final String rfc;
  final String street;
  final String reference;
  late final List<ProductModel> saucers;

  StoreModel({
    required this.closingTime,
    required this.openingTime,
    required this.neighborhood,
    required this.number,
    required this.id,
    required this.image,
    required this.city,
    required this.name,
    required this.phone,
    required this.street,
    required this.rfc,
    required this.reference,


    List<ProductModel>? saucers,
  }) : saucers = saucers ?? [] {
    imageProvider = _getImageProvider();
  }

  Map<String, dynamic> toJson() => {
    'closingTime': closingTime,
    'openingTime': openingTime,
    'address': neighborhood,
    'id': id,
    'image': image,
    'location': city,
    'name': name,
    'phone': phone,
    'number': number,
    'saucers': saucers.map((saucer) => saucer.toJson()).toList(),
  };

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      closingTime: json['closing_hours'],
      openingTime: json['opening_hours'],
      image: json['image'],
      neighborhood: json['neighborhood'],
      number: json['number'],
      id: json['uuid'],
      city: json['city'],
      name: json['name'],
      phone: json['phone_number'],
      reference: json['reference'],
      street: json['street'],
      rfc: json['rfc'],
      saucers: (json['saucers'] as List<dynamic>?)
          ?.map((saucerJson) => ProductModel.fromJson(saucerJson))
          .toList() ?? [],
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

