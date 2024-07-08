import 'package:crud_r/domain/models/store_model.dart';
import 'package:crud_r/domain/models/user_model.dart';
import 'package:crud_r/domain/repositories/store_repository.dart';
import 'package:crud_r/domain/repositories/user_repository.dart';

class GetUserByEmail{
  final UserRepository userRepository;

  GetUserByEmail(this.userRepository);

   Future<UserModel> execute(String token, String email) {
    return userRepository.getUserByEmail(token, email);

  }
}
