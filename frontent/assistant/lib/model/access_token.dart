class AccessToken {
  final String _token;
  final String _tokenType;
  final DateTime _expires;

  String get token => _token;
  String get tokenType => _tokenType;
  DateTime get expires => _expires;

  AccessToken(
      {required String token,
      required String tokenType,
      required DateTime expires})
      : _token = token,
        _tokenType = tokenType,
        _expires = expires;
  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      token: json['token'],
      tokenType: json['tokenType'],
      expires: DateTime.parse(json['expires']),
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'tokenType': tokenType,
        'expires': expires.toIso8601String(),
      };
}
