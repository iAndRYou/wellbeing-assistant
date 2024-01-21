import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/model/access_token.dart';
import 'package:assistant/model/refresh_token.dart';
import 'package:tuple/tuple.dart';

class AuthRepository {
  final SharedPreferencesRepository _preferencesRepository;
  final HttpServiceRepository _httpServiceRepository;

  AuthRepository(
      {required SharedPreferencesRepository preferencesRepository,
      required HttpServiceRepository httpServiceRepository})
      : _preferencesRepository = preferencesRepository,
        _httpServiceRepository = httpServiceRepository;

  void _storeTokens(Tuple2<AccessToken, RefreshToken> tokenPair) {
    _preferencesRepository.storeAccessToken(tokenPair.item1);
    _preferencesRepository.storeRefreshToken(tokenPair.item2);
  }

  Future<void> registerUserAndStoreTokens(
      {required String username,
      required String email,
      required String password}) async {
    var tokenPair = await _httpServiceRepository.getRegisterTokenPair(
        username: username, email: email, password: password);
    _storeTokens(tokenPair);
  }

  Future<void> loginUserAndStoreTokens(
      {required String username, required String password}) async {
    var tokenPair = await _httpServiceRepository.getLoginTokenPair(
        username: username, password: password);
    _storeTokens(tokenPair);
  }

  Future<void> logoutUserAndRemoveTokens() async {
    await _preferencesRepository.removeStoredAccessToken();
    await _preferencesRepository.removeStoredRefreshToken();
    await _preferencesRepository.removeStoredFavorite();
  }

  Future<void> refreshSessionAndStoreTokens(
      {required AccessToken accessToken,
      required RefreshToken refreshToken}) async {
    var tokenPair = await _httpServiceRepository.getRefreshTokenPair(
        accessToken: accessToken, refreshToken: refreshToken);
    _storeTokens(tokenPair);
  }
}
