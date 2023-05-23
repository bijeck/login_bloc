import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/auth/auth_repository.dart';
import 'package:login_bloc/auth/confirm/confirmation_event.dart';
import 'package:login_bloc/auth/confirm/confirmation_state.dart';
import 'package:login_bloc/auth/form_submission_status.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepository;

  ConfirmationBloc({required this.authRepository}) : super(ConfirmationState()) {
    on<ConfirmationCodeChanged>(_onConfirmationCodeChanged);
    on<ConfirmationSubmitted>(_onConfirmationSubmitted);
  }

  void _onConfirmationCodeChanged(
    ConfirmationCodeChanged event,
    Emitter<ConfirmationState> emit,
  ) {
    print('code changed');
    emit(state.copyWith(code: event.code));
  }


  void _onConfirmationSubmitted(
    ConfirmationSubmitted event,
    Emitter<ConfirmationState> emit,
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
