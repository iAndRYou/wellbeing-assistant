class UserDevice {
  final int _userDeviceId;
  final String _name;

  int get userDeviceId => _userDeviceId;
  String get name => _name;

  UserDevice({required int userDeviceId, required String name})
      : _userDeviceId = userDeviceId,
        _name = name;
  factory UserDevice.fromJson(Map<String, dynamic> json) {
    return UserDevice(
      userDeviceId: json['userDeviceId'],
      name: json['name'],
    );
  }
}
