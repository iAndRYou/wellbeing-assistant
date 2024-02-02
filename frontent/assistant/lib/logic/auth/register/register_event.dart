abstract class RegisterEvent {}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;

  RegisterUsernameChanged({required this.username});
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({required this.password});
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;

  RegisterConfirmPasswordChanged({required this.confirmPassword});
}

class RegisterSubmitted extends RegisterEvent {}
