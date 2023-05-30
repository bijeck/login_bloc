import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_cubit.dart';
import 'package:login_bloc/auth/auth_repository.dart';
import 'package:login_bloc/auth/confirm/confirmation_event.dart';
import 'package:login_bloc/auth/confirm/confirmation_state.dart';
import 'package:login_bloc/auth/form_submission_status.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepository,
    required this.authCubit,
  }) : super(ConfirmationState()) {
    on<ConfirmationCodeChanged>(_onConfirmationCodeChanged);
    on<ConfirmationSubmitted>(_onConfirmationSubmitted);
  }

  void _onConfirmationCodeChanged(
    ConfirmationCodeChanged event,
    Emitter<ConfirmationState> emit,
  ) {
    emit(state.copyWith(code: event.code));
  }

  void _onConfirmationSubmitted(
    ConfirmationSubmitted event,
    Emitter<ConfirmationState> emit,
  ) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      final userId = await authRepository.confirmSignup(
        username: authCubit.credentials!.username,
        confirmationCode: state.code,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      final credential = authCubit.credentials;
      credential!.userId = userId;

      authCubit.launchSession(credential);
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
    }
  }
}
