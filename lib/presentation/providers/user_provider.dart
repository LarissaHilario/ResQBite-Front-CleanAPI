// lib/presentation/providers/user_provider.dart
import 'package:crud_r/domain/models/user_model.dart';
import 'package:crud_r/domain/repositories/user_repository.dart';
import 'package:crud_r/infraestructure/repositories/user_repository_impl.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  final UserRepository _userRepository = UserRepositoryImpl();
  String? _token;

  UserModel? get user => _user;

  Future<void> login(String email, String password) async {
    _user = await _userRepository.loginUser(email, password);
    _token = _user?.token;
    await _userRepository.savePassword(password);
    notifyListeners();
  }

  void clearUser() async {
    _user = null;
    _token = null;
    await _userRepository.deletePassword();
    notifyListeners();
  }
  Future<void> updateUserLocation(String token, String location) async {
    try {
      await _userRepository.updateUserLocation(token, location);
      notifyListeners();
    } catch (e) {
      print('Error updating location: $e');
    }
  }
}
