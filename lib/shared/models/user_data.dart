import 'dart:convert';

class UserData {
  final String email;
  final String password;
  final String uid;

  UserData({
    required this.email,
    required this.password,
    required this.uid,
  });

  UserData copyWith({
    String? email,
    String? password,
    String? uid,
  }) {
    return UserData(
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'uid': uid,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      email: map['email'],
      password: map['password'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData && other.email == email;
  }

  @override
  int get hashCode {
    return email.hashCode ^
    uid.hashCode;
  }
}
