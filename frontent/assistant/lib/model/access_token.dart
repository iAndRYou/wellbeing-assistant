class AccessToken {
  final String _token;
  final String _tokenType;

  String get token => _token;
  String get tokenType => _tokenType;

  AccessToken({required String token, required String tokenType})
      : _token = token,
        _tokenType = tokenType;
  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      token: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': token,
        'token_type': tokenType,
      };
}
