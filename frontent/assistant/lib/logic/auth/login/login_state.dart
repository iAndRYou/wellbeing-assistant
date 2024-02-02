import 'package:assistant/logic/auth/form_submit_status.dart';

class LoginState {
  final String email;
  final String password;
  final FormSubmitStatus formStatus;

  bool get allFieldsFilled => email.isNotEmpty && password.isNotEmpty;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormSubmitStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmitStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
