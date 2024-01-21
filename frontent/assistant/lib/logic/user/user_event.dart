abstract class UserEvent {}

class UserAppStartup extends UserEvent {}

class UserRefresh extends UserEvent {}

class UserLogout extends UserEvent {}

class UserUpdate extends UserEvent {}

class UserFavouriteChanged extends UserEvent {
  final int favourite;

  UserFavouriteChanged({required this.favourite});
}
