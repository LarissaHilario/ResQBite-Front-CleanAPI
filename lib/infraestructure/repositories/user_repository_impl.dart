import 'dart:convert';
import 'dart:io';

import 'package:crud_r/domain/models/user_model.dart';
import 'package:crud_r/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> loginUser(String email, String password) async {
    const url = 'http://3.223.7.73/signin/';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body);
      return UserModel(token: token, email: email);
    } else {
      print('errorrrr');
      throw Exception('Failed to login');
    }
  }

  @override
  registerUser(String name, String lastName, String email,
      String password) async {
    const url = 'http://3.223.7.73/signup';
    final userData = {
      'name': name,
      'last_name': lastName,
      'email': email,
      'password': password,
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

    if (response.statusCode == 308) {
      final redirectUrl = response.headers["location"];
      if (redirectUrl != null) {
        final getResponse = await http.post(
          Uri.parse(redirectUrl),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(userData),
        );

        print('Redirect response status code: ${getResponse.statusCode}');
        print('Redirect response body: ${getResponse.body}');

        if (getResponse.statusCode == 200) {
          final responseBody = jsonDecode(getResponse.body);
          return responseBody['user'] == true;
        }
      }
      else {
        throw Exception('Failed to register user after redirection');
      }
    }
  }
}





