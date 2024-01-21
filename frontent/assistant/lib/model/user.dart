class User {
  final int _id;
  final String _name;
  final String _email;

  int get id => _id;
  String get name => _name;
  String get email => _email;
  bool get isEmpty => _name.isEmpty && _email.isEmpty;
  bool get isNotEmpty => !isEmpty;

  User({required int id, required String name, required String email})
      : _id = id,
        _name = name,
        _email = email;

  const User.emptyValues({int id = 0, String name = '', String email = ''})
      : _id = id,
        _name = name,
        _email = email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
