import 'package:assistant/logic/auth/form_submit_status.dart';

class LoginState {
  final String username;
  final String password;
  final FormSubmitStatus formStatus;

  bool get allFieldsFilled => username.isNotEmpty && password.isNotEmpty;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormSubmitStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmitStatus? formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
