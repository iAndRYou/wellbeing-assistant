import 'package:assistant/logic/auth/form_submit_status.dart';

class RegisterState {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final FormSubmitStatus formStatus;

  bool get isValidEmail => email.contains('@');
  bool get isValidPassword => password.length > 6;
  bool get isValidConfirmPassword => confirmPassword == password;
  bool get allFieldsFilled =>
      username.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  RegisterState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.formStatus = const InitialFormSubmitStatus(),
  });

  RegisterState copyWith({
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    FormSubmitStatus? formStatus,
  }) {
    return RegisterState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
