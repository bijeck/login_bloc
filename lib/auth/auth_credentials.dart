class AuthCredentials {
  final String username;
  String? password;
  String? email;
  String? userId;

  AuthCredentials({
    required this.username,
    this.password,
    this.email,
    this.userId,
  });
}
