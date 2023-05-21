import 'package:login_bloc/auth/form_submission_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length > 2;

  final String password;
  bool get isValidPassword => password.length > 3;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
