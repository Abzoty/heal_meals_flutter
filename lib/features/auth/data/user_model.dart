class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;
  final String gender;
  final String dateOfBirth;
  final String address;
  final String healthId;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
    required this.healthId,
    required this.phone,
  });

  /// Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      healthId: json['healthId'],
      phone: json['phone'],
    );
  }

  /// Convert User object back to JSON (useful if updating User)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "gender": gender,
      "dateOfBirth": dateOfBirth,
      "address": address,
      "healthId": healthId,
      "phone": phone,
    };
  }
}
