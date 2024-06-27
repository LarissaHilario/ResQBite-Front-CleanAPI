import 'dart:convert';
import 'package:crud_r/domain/models/product_model.dart';
import 'package:flutter/material.dart';

class StoreModel {
  final String address;
  final int id;
  final String image;
  final String location;
  final String name;
  final String phone;



  StoreModel({
    required this.address,
    required this.id,
    required this.image,
    required this.location,
    required this.name,
    required this.phone,

  });

  Map<String, dynamic> toJson() => {
    'address' : address,
    'id': id,
    'image': image,
    'location': location,
    'name': name,
    'phone': phone,

  };

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      address: json['address'],
      id: json['id'],
      image: json['image'],
      location: json['location'],
      name: json['name'],
      phone: json['phone'],

    );
  }
}
