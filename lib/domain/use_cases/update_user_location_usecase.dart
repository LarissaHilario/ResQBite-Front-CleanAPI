
import 'package:crud_r/domain/repositories/user_repository.dart';

class UpdateUserLocationUseCase {
  final UserRepository repository;

  UpdateUserLocationUseCase(this.repository);

  Future<void> call(String token, String location) async {
    await repository.updateUserLocation(token, location);
  }
}
