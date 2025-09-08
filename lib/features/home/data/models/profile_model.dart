class Profile {
  //final int id;
  final String name;
  final String email;
  final String role;
  final String gender;
  final String dateOfBirth;
  final String address;
  final String healthId;
  final String phone;

  Profile({
    //required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
    required this.healthId,
    required this.phone,
  });

  /// Factory constructor to create a Profile from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      //id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      healthId: json['healthId'],
      phone: json['phone'],
    );
  }

  /// Convert Profile object back to JSON (useful if updating profile)
  Map<String, dynamic> toJson() {
    return {
      //"id": id,
      "name": name,
      "email": email,
      "role": role,
      "gender": gender,
      "dateOfBirth": dateOfBirth,
      "address": address,
      "healthId": healthId,
      "phone": phone,
    };
  }
}
