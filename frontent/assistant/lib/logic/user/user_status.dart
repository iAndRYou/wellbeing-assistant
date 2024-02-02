abstract class UserStatus {
  const UserStatus();
}

class UserInitial extends UserStatus {
  const UserInitial();
}

class UserLoadingLocallyStoredTokens extends UserStatus {}

class UserLocallyAuthorized extends UserStatus {}

class UserLocallyUnauthorized extends UserStatus {}
