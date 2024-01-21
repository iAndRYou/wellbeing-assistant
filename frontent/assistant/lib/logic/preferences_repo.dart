import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:assistant/model/access_token.dart';
import 'package:assistant/model/refresh_token.dart';

class SharedPreferencesRepository {
  final _prefs = SharedPreferences.getInstance();

  Future<void> storeAccessToken(AccessToken accessToken) async =>
      await _prefs.then((prefs) =>
          prefs.setString('accessToken', jsonEncode(accessToken.toJson())));

  Future<void> storeRefreshToken(RefreshToken refreshToken) async =>
      await _prefs.then((prefs) =>
          prefs.setString('refreshToken', jsonEncode(refreshToken.toJson())));

  Future<void> saveFavorite(int favorite) async =>
      await _prefs.then((prefs) => prefs.setInt('favorite', favorite));

  Future<void> removeStoredAccessToken() async =>
      await _prefs.then((prefs) => prefs.remove('accessToken'));

  Future<void> removeStoredRefreshToken() async =>
      await _prefs.then((prefs) => prefs.remove('refreshToken'));

  Future<void> removeStoredFavorite() async =>
      await _prefs.then((prefs) => prefs.remove('favorite'));

  Future<AccessToken> getSavedAccessToken() async {
    return await _prefs.then((prefs) =>
        AccessToken.fromJson(jsonDecode(prefs.getString('accessToken')!)));
  }

  Future<RefreshToken> getSavedRefreshToken() async {
    return await _prefs.then((prefs) =>
        RefreshToken.fromJson(jsonDecode(prefs.getString('refreshToken')!)));
  }

  Future<int> getSavedFavorite() async {
    return await _prefs.then((prefs) => prefs.getInt('favorite') ?? -1);
  }
}
