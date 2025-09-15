class User {
  final String name;
  final String email;
  final String password;
  final String role;
  final String gender;
  final String dob;
  final String address;
  final String healthId;
  final String phone;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.dob,
    required this.address,
    required this.healthId,
    required this.phone,
  });

  /// Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      gender: json['gender'],
      dob: json['dob'],
      address: json['address'],
      healthId: json['healthId'],
      phone: json['phone'],
    );
  }

  /// Convert User object back to JSON (useful if updating User)
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "gender": gender,
      "dob": dob,
      "address": address,
      "healthId": healthId,
      "phone": phone,
    };
  }
}
