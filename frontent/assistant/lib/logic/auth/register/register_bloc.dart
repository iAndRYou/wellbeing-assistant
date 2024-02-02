import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assistant/logic/auth/form_submit_status.dart';
import 'package:assistant/logic/auth/register/register_event.dart';
import 'package:assistant/logic/auth/register/register_state.dart';
import 'package:assistant/logic/auth/auth_repo.dart';
import 'package:assistant/logic/http_repo.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepo;
  RegisterBloc({required this.authRepo}) : super(RegisterState()) {
    on<RegisterUsernameChanged>(
        ((event, emit) => emit(state.copyWith(username: event.username))));

    on<RegisterEmailChanged>(
        ((event, emit) => emit(state.copyWith(email: event.email))));

    on<RegisterPasswordChanged>(
        ((event, emit) => emit(state.copyWith(password: event.password))));

    on<RegisterConfirmPasswordChanged>((event, emit) =>
        emit(state.copyWith(confirmPassword: event.confirmPassword)));

    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.registerUserAndStoreToken(
          username: state.username,
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(formStatus: FormSubmissionSuccess()));
        await Future.delayed(const Duration(seconds: 1));
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
