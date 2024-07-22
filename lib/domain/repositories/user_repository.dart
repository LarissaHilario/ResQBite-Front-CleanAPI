import 'package:crud_r/domain/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> loginUser(String email, String password);
  registerUser(String name, String lastName, String email, String password, String phone);
  getUserByEmail(String token, String email);
  updateUserLocation (String token, String location);
  Future<void> updateUserProfile(String token, Map<String, dynamic> updatedData);
  Future<void> savePassword(String password);
  Future<String?> getPassword();
  Future<void> deletePassword();

}