import 'package:assistant/logic/user/user_status.dart';
import 'package:assistant/model/user.dart';
import 'package:assistant/model/user_device.dart';

class UserState {
  final User user;
  final int favourite;
  final UserStatus status;

  String get username => user.username;
  String get email => user.email;

  bool get hasDevices => user.devices.isNotEmpty;
  List<UserDevice> get devices => user.devices;

  UserState({
    this.user = const User.emptyValues(),
    this.favourite = -1,
    this.status = const UserInitial(),
  });

  UserState copyWithUser({
    User? user,
    int? favourite,
    UserStatus? status,
  }) {
    return UserState(
      user: user ?? this.user,
      favourite: favourite ?? this.favourite,
      status: status ?? this.status,
    );
  }

  UserState copyWithValues({
    String? username,
    String? email,
    List<UserDevice>? devices,
    int? favourite,
    UserStatus? status,
  }) {
    return UserState(
      user: user.copyWith(
        username: username,
        email: email,
        devices: devices,
      ),
      favourite: favourite ?? this.favourite,
      status: status ?? this.status,
    );
  }
}
