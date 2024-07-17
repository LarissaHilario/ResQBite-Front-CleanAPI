class UserModel {
  final String token;
  final String email;
  final String? location;

  UserModel({required this.token, required this.email, this.location});
}
