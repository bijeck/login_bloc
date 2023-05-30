import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_credentials.dart';
import 'package:login_bloc/session_cubit.dart';

enum AuthState { login, signUp, cofirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showCofirmSignUp({
    required String username,
    required String password,
    required String email,
  }) {
    credentials = AuthCredentials(
      username: username,
      password: password,
      email: email,
    );
    emit(AuthState.cofirmSignUp);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
