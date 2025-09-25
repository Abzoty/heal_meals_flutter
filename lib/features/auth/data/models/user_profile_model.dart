import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  final String userId;
  final String name;
  final String email;
  final String role;
  final String gender;
  final String dob;
  final String address;
  final String phone;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    required this.gender,
    required this.dob,
    required this.address,
    required this.phone,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}