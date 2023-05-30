import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_cubit.dart';
import 'package:login_bloc/auth/auth_repository.dart';
import 'package:login_bloc/auth/form_submission_status.dart';
import 'package:login_bloc/auth/sign_up/sign_up_event.dart';
import 'package:login_bloc/auth/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  SignUpBloc({
    required this.authRepository,
    required this.authCubit,
  }) : super(SignUpState()) {
    on<SignUpUsernameChanged>(_onSignUpUsernameChanged);
    on<SignUpPasswordChanged>(_onSignUpPasswordChanged);
    on<SignUpEmailChanged>(_onSignUpEmailChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpUsernameChanged(
    SignUpUsernameChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  void _onSignUpPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _onSignUpEmailChanged(
    SignUpEmailChanged event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      await authRepository.signUp(
        username: state.username,
        password: state.password,
        email: state.email,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.showCofirmSignUp(
        username: state.username,
        password: state.password,
        email: state.email,
      );
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
    }
  }
}
