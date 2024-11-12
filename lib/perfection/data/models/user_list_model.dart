class User {
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
      email: json['email'], // Add email here
    );
  }
}
