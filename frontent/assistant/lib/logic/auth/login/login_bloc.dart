import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assistant/logic/auth/auth_repo.dart';
import 'package:assistant/logic/auth/form_submit_status.dart';
import 'package:assistant/logic/auth/login/login_event.dart';
import 'package:assistant/logic/auth/login/login_state.dart';
import 'package:assistant/logic/http_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<LoginUsernameChanged>(
        ((event, emit) => emit(state.copyWith(email: event.email))));

    on<LoginPasswordChanged>(
        ((event, emit) => emit(state.copyWith(password: event.password))));

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.loginUserAndStoreToken(
          username: state.email,
          password: state.password,
        );
        await Future.delayed(const Duration(seconds: 1));
        emit(state.copyWith(formStatus: FormSubmissionSuccess()));
      } on HttpServiceTimeoutException catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionTimeout(e)));
        emit(state.copyWith(formStatus: const InitialFormSubmitStatus()));
      } on HttpServiceException catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionFailed(e)));
        emit(state.copyWith(formStatus: const InitialFormSubmitStatus()));
      }
    });
  }
}
