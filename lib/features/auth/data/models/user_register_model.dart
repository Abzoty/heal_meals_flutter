import 'package:json_annotation/json_annotation.dart';

part 'user_register_model.g.dart';

@JsonSerializable()
class UserRegisterModel {
  final String name;
  final String email;
  final String password;
  final String role;
  final String gender;
  final String dob;
  final String address;
  final String phone;
  
  UserRegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.dob,
    required this.address,
    required this.phone,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) => _$UserRegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserRegisterModelToJson(this);
}
