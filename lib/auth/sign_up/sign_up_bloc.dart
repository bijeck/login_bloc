import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_repository.dart';
import 'package:login_bloc/auth/form_submission_status.dart';
import 'package:login_bloc/auth/sign_up/sign_up_event.dart';
import 'package:login_bloc/auth/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({required this.authRepository}) : super(SignUpState()) {
    on<SignUpUsernameChanged>(_onSignUpUsernameChanged);
    on<SignUpPasswordChanged>(_onSignUpPasswordChanged);
    on<SignUpEmailChanged>(_onSignUpEmailChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpUsernameChanged(
    SignUpUsernameChanged event,
    Emitter<SignUpState> emit,
  ) {
    print('username changed');
    emit(state.copyWith(username: event.username));
  }

  void _onSignUpPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    print('password changed');
    emit(state.copyWith(password: event.password));
  }

  void _onSignUpEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) {
    print('password changed');
    emit(state.copyWith(password: event.email));
  }

  void _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
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
