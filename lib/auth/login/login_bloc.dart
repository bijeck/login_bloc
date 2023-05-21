import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_repository.dart';
import 'package:login_bloc/auth/form_submission_status.dart';
import 'package:login_bloc/auth/login/login_event.dart';
import 'package:login_bloc/auth/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginState()) {
    on<LoginUsernameChanged>(_onLoginUsernameChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    print('username changed');
    emit(state.copyWith(username: event.username));
  }

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    print('password changed');
    emit(state.copyWith(password: event.password));
  }

  void _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    print('submitted');
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      await authRepository.login();
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
    }
  }
}
