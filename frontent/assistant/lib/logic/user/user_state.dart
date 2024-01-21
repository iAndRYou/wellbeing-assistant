import 'package:assistant/logic/user/user_status.dart';
import 'package:assistant/model/user.dart';

class UserState {
  final User user;
  final UserStatus status;

  String get name => user.name;
  String get email => user.email;

  UserState({
    this.user = const User.emptyValues(),
    this.status = const UserInitial(),
  });

  UserState copyWithUser({
    User? user,
    int? favourite,
    UserStatus? status,
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  UserState copyWithValues({
    int? id,
    String? username,
    String? email,
    int? favourite,
    UserStatus? status,
  }) {
    return UserState(
      user: user.copyWith(
        id: id,
        name: username,
        email: email,
      ),
      status: status ?? this.status,
    );
  }
}
