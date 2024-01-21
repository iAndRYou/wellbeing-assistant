import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assistant/logic/auth/auth_repo.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/user/user_event.dart';
import 'package:assistant/logic/user/user_state.dart';
import 'package:assistant/logic/user/user_status.dart';
import 'package:assistant/model/user.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepo;
  final HttpServiceRepository httpRepo;
  final SharedPreferencesRepository preferencesRepo;
  UserBloc(
      {required this.authRepo,
      required this.httpRepo,
      required this.preferencesRepo})
      : super(UserState()) {
    on<UserAppStartup>((event, emit) async {
      emit(state.copyWithValues(status: UserLoadingLocallyStoredTokens()));
      try {
        var accessToken = await preferencesRepo.getSavedAccessToken();

        emit(state.copyWithUser(
            user:
                await httpRepo.getAuthenticatedUser(accessToken: accessToken)));

        emit(state.copyWithValues(status: UserLocallyAuthorized()));
      } catch (e) {
        emit(state.copyWithUser(
            user: const User.emptyValues(), status: UserLocallyUnauthorized()));
      }
    });

    on<UserLogout>((event, emit) async {
      await authRepo.logoutUserAndRemoveToken();
      emit(state.copyWithUser(user: const User.emptyValues()));
    });

    on<UserUpdate>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();
      emit(state.copyWithUser(
          user: await httpRepo.getAuthenticatedUser(accessToken: accessToken)));
    });
  }
}
