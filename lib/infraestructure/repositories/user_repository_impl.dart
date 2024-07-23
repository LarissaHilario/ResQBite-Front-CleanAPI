import 'dart:convert';
import 'dart:io';

import 'package:crud_r/domain/models/user_model.dart';
import 'package:crud_r/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  Future<UserModel> loginUser(String email, String password) async {
    const url = 'https://resqbite-gateway.integrador.xyz:3000/api/v1/user/signin';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];

      return UserModel(token: token, email: email);
    } else {
      print('errorrrr');
      throw Exception('Failed to login');
    }
  }

  @override
  Future<bool> registerUser(String name, String lastName, String email, String password, String phone) async {
    const url = 'https://resqbite-gateway.integrador.xyz:3000/api/v1/user/signup';
    final userData = {
      'email': email,
      'password': password,
      'location': 'suchiapa',
      'user_type_suscriber': "COMUN",
      'contact': {
        'name': name,
        'last_name': lastName,
        'address': 'suchiapa',
        "phone_number": phone,
      },
    };

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    print('Initial response status code: ${response.statusCode}');
    print('Initial response headers: ${response.headers}');

    // Check if response status indicates successful user creation
    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('user') && responseBody['user'] is Map) {
        return true; // Assuming user creation was successful
      } else {
        throw Exception('Unexpected response format');
      }
    }

    throw Exception('Failed to register user');
  }


  @override
  Future<Map<String, dynamic>> getUserByEmail(
      String token, String email) async {
    const url = 'https://resqbite-gateway.integrador.xyz:3000/api/v1/user/user_by_email';
    final response = await Dio().get(
      url,
      queryParameters: {'email': email},
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      ),
    );
    if (response.statusCode == 200) {
      final responseData = response.data;
      return responseData['user'];
    } else {
      throw Exception('Failed to get user by email');
    }
  }

  @override
  updateUserLocation(String token, String location) async {
    const url = 'https://resqbite-gateway.integrador.xyz:3000/api/v1/user/update_location';
    final body = jsonEncode({
      'location': location,
    });

    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print('Location updated successfully');
    } else {
      print('Failed to update location: ${response.statusCode}');
      throw Exception('Failed to update location');
    }
  }

  @override
  Future<void> updateUserProfile(
      String token, Map<String, dynamic> updatedData) async {
    print(updatedData);
    try {
      final response = await Dio().put(
        'https://resqbite-gateway.integrador.xyz:3000/api/v1/user/update_user',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        ),
        data: updatedData,
      );

      print('Update response status code: ${response.statusCode}');
      print('Update response data: ${response.data}');

      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      print('Error updating user profile: $e');
      throw Exception('Failed to update user profile: $e');
    }
  }
  Future<void> savePassword(String password) async {
    await _secureStorage.write(key: 'user_password', value: password);
  }

  Future<String?> getPassword() async {
    return await _secureStorage.read(key: 'user_password');
  }

  Future<void> deletePassword() async {
    await _secureStorage.delete(key: 'user_password');
  }
}
