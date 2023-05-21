// ignore_for_file: avoid_print
class AuthRepository {
  Future<void> login() async {
    print('attempting login');
    await Future.delayed(const Duration(seconds: 2));
    print('logged in');
    if (DateTime.now().millisecondsSinceEpoch % 2.0 != 0) {
      throw Exception('Login failed');
    }
  }
}
