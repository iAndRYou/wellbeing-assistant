import 'dart:convert';
import 'package:assistant/model/access_token.dart';
import 'package:assistant/model/history_item.dart';
import 'package:http/http.dart';
import 'package:assistant/model/user.dart';

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
  final String _apiAddress = 'http://10.0.2.2:8000';
  final Duration _timeoutDuration = const Duration(seconds: 5);

  get _throwTimeoutException =>
      () => throw HttpServiceTimeoutException('Connection timed out');

  AccessToken _getTokenFrom({required Response response}) {
    var responseBody = jsonDecode(response.body);
    return AccessToken.fromJson(responseBody);
  }

  User _getUserFrom({required Response response}) {
    var responseBody = jsonDecode(response.body);
    return User.fromJson(responseBody);
  }

  List<HistoryItem> _getHistoryFrom({required Response response}) {
    var responseBody = jsonDecode(response.body);
    return responseBody
        .map<HistoryItem>((item) => HistoryItem.fromJson(item))
        .toList();
  }

  Future<AccessToken> getRegisterToken(
      {required String name,
      required String email,
      required String password}) async {
    var response = await post(
      Uri.parse('$_apiAddress/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'name': name,
          'email': email,
          'password': password,
        },
      ),
    ).timeout(_timeoutDuration, onTimeout: _throwTimeoutException);

    print('register');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return _getTokenFrom(response: response);
    } else if (response.statusCode == 500) {
      throw HttpServiceServerException();
    } else {
      throw HttpServiceException('Username taken');
    }
  }

  Future<AccessToken> getLoginTokenPair(
      {required String username, required String password}) async {
    var response = await post(Uri.parse('$_apiAddress/auth/login'),
            headers: <String, String>{
              'Content-Type':
                  'application/x-www-form-urlencoded; charset=UTF-8',
            },
            body: 'username=$username&password=$password')
        .timeout(_timeoutDuration, onTimeout: _throwTimeoutException);

    print('login');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return _getTokenFrom(response: response);
    } else if (response.statusCode == 500) {
      throw HttpServiceServerException();
    } else {
      throw HttpServiceException('Invalid credentials');
    }
  }

  Future<User> getAuthenticatedUser({required AccessToken accessToken}) async {
    var response = await get(
      Uri.parse('$_apiAddress/users/me'),
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

  Future<List<HistoryItem>> getUserHistory(
      {required AccessToken accessToken}) async {
    var response = await get(
      Uri.parse('$_apiAddress/users/history'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${accessToken.tokenType} ${accessToken.token}',
      },
    ).timeout(_timeoutDuration, onTimeout: _throwTimeoutException);

    print('history');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return _getHistoryFrom(response: response);
    } else if (response.statusCode == 500) {
      throw HttpServiceServerException();
    } else {
      throw Exception();
    }
  }
}
