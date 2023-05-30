import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_credentials.dart';
import 'package:login_bloc/auth/auth_repository.dart';
import 'package:login_bloc/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepository;
  SessionCubit({required this.authRepository}) : super(UnknowSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepository.attemptAutoLogin();

      final user = userId;

      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());

  void showSession(AuthCredentials credentials) {
    final user = credentials.username;

    emit(Authenticated(user: user));
  }

  void signOut() {
    authRepository.signOut();

    emit(Unauthenticated());
  }
}
