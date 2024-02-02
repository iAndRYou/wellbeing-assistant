import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/model/access_token.dart';

class AuthRepository {
  final SharedPreferencesRepository _preferencesRepository;
  final HttpServiceRepository _httpServiceRepository;

  AuthRepository(
      {required SharedPreferencesRepository preferencesRepository,
      required HttpServiceRepository httpServiceRepository})
      : _preferencesRepository = preferencesRepository,
        _httpServiceRepository = httpServiceRepository;

  void _storeToken(AccessToken token) {
    _preferencesRepository.storeAccessToken(token);
  }

  Future<void> registerUserAndStoreToken(
      {required String username,
      required String email,
      required String password}) async {
    var tokenPair = await _httpServiceRepository.getRegisterToken(
        name: username, email: email, password: password);
    _storeToken(tokenPair);
  }

  Future<void> loginUserAndStoreToken(
      {required String username, required String password}) async {
    var tokenPair = await _httpServiceRepository.getLoginTokenPair(
        username: username, password: password);
    _storeToken(tokenPair);
  }

  Future<void> logoutUserAndRemoveToken() async {
    await _preferencesRepository.removeStoredAccessToken();
  }
}
