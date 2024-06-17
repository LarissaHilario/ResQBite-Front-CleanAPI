import 'package:crud_r/domain/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> loginUser(String email, String password);
}