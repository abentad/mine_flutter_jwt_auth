import 'dart:convert';

class User {
  String? userId;
  String? username;
  String? email;
  String? token;
  User({this.userId, this.username, this.email, this.token});

  User copyWith({String? userId, String? username, String? email, String? token}) {
    return User(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      username: map['username'],
      email: map['email'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userId: $userId, username: $username, email: $email, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.userId == userId && other.username == username && other.email == email && other.token == token;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ username.hashCode ^ email.hashCode ^ token.hashCode;
  }
}
