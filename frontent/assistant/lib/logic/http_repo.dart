import 'dart:convert';
import 'package:assistant/model/access_token.dart';
import 'package:assistant/model/refresh_token.dart';
import 'package:http/http.dart';
import 'package:assistant/model/user.dart';
import 'package:tuple/tuple.dart';

class HttpServiceException implements Exception {
  final String _message;

  HttpServiceException(this._message);

  @override
  String toString() {
    return _message;
  }
}

class HttpServiceTimeoutException extends HttpServiceException {
  HttpServiceTimeoutException(String message) : super(message);
}

class HttpServiceServerException extends HttpServiceException {
  HttpServiceServerException() : super('Internal server error');
}

class HttpServiceRepository {
  final String _apiAddress = 'http://10.0.2.2:5100';
  final Duration _timeoutDuration = const Duration(seconds: 5);

  get _throwTimeoutException =>
      () => throw HttpServiceTimeoutException('Connection timed out');

  Tuple2<AccessToken, RefreshToken> _getTokenPairFrom(
      {required Response response}) {
    var responseBody = jsonDecode(response.body);
    return Tuple2(AccessToken.fromJson(responseBody['accessToken']),
        RefreshToken.fromJson(responseBody['refreshToken']));
  }

  User _getUserFrom({required Response response}) {
    var responseBody = jsonDecode(response.body);
    return User.fromJson(responseBody);
  }

  Future<Tuple2<AccessToken, RefreshToken>> getRegisterTokenPair(
      {required String username,
      required String email,
      required String password}) async {
    var response = await post(
      Uri.parse('$_apiAddress/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'password': password,
        },
      ),
    ).timeout(_timeoutDuration, onTimeout: _throwTimeoutException);

    print('register');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return _getTokenPairFrom(response: response);
    } else if (response.statusCode == 500) {
      throw HttpServiceServerException();
    } else {
      throw HttpServiceException('Username taken');
    }
  }

  Future<Tuple2<AccessToken, RefreshToken>> getLoginTokenPair(
      {required String username, required String password}) async {
    var response = await post(
      Uri.parse('$_apiAddress/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password': password,
        },
      ),
    ).timeout(_timeoutDuration, onTimeout: _throwTimeoutException);

    print('login');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return _getTokenPairFrom(response: response);
    } else if (response.statusCode == 500) {
      throw HttpServiceServerException();
    } else {
      throw HttpServiceException('Invalid credentials');
    }
  }

  Future<Tuple2<AccessToken, RefreshToken>> getRefreshTokenPair(
      {required AccessToken accessToken,
      required RefreshToken refreshToken}) async {
    var response = await post(
      Uri.parse('$_apiAddress/auth/refresh'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'accessToken': accessToken.token,
          'refreshToken': refreshToken.token,
        },
      ),
    ).timeout(_timeoutDuration, onTimeout: _throwTimeoutException);

    print('refresh');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return _getTokenPairFrom(response: response);
    } else if (response.statusCode == 500) {
      throw HttpServiceServerException();
    } else {
      throw Exception();
    }
  }

  Future<User> getAuthenticatedUser({required AccessToken accessToken}) async {
    var response = await get(
      Uri.parse('$_apiAddress/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${accessToken.tokenType} ${accessToken.token}',
      },
    ).timeout(_timeoutDuration, onTimeout: _throwTimeoutException);

    print('user');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return _getUserFrom(response: response);
    } else if (response.statusCode == 500) {
      throw HttpServiceServerException();
    } else {
      throw Exception();
    }
  }
}
