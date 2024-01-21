class RefreshToken {
  final String _token;
  final DateTime _expires;

  String get token => _token;
  DateTime get expires => _expires;

  RefreshToken({required String token, required DateTime expires})
      : _token = token,
        _expires = expires;
  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(
      token: json['token'],
      expires: DateTime.parse(json['expires']),
    );
  }

  Map<String, dynamic> toJson() => {
        'token': _token,
        'expires': _expires.toIso8601String(),
      };
}
