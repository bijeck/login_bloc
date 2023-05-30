class AuthRepository {
  Future<String> attemptAutoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('not signed in');
  }

  Future<String> login({
    required username,
    required password,
  }) async {
    print('attempting to login');
    await Future.delayed(const Duration(seconds: 2));
    return 'abc';
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<String> confirmSignup({
    required String username,
    required String confirmationCode,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'abc';
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
