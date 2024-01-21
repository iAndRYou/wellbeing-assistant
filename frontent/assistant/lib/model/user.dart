import 'package:assistant/model/user_device.dart';

class User {
  final String _username;
  final String _email;
  final List<UserDevice> _devices;

  String get username => _username;
  String get email => _email;
  List<UserDevice> get devices => _devices;
  bool get isEmpty => _username.isEmpty && _email.isEmpty && _devices.isEmpty;
  bool get isNotEmpty => !isEmpty;

  User(
      {required String username,
      required String email,
      required List<UserDevice> devices})
      : _username = username,
        _email = email,
        _devices = devices;

  const User.emptyValues(
      {String username = '',
      String email = '',
      List<UserDevice> devices = const []})
      : _username = username,
        _email = email,
        _devices = devices;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      devices: (json['devices'] as List<dynamic>)
          .map((e) => UserDevice.fromJson(e))
          .toList(),
    );
  }

  User copyWith({
    String? username,
    String? email,
    List<UserDevice>? devices,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      devices: devices ?? this.devices,
    );
  }
}
