import 'package:json_annotation/json_annotation.dart';

part 'donation_model.g.dart';

@JsonSerializable()
class DonationModel {
  final String firstName;
  final String secondName;
  final String phoneNumber;
  final String email;
  final double amount;
  final String message;
  final String cardNumber;
  final String expiryDate; // format: MM/YY
  final String cvv;

  DonationModel({
    required this.firstName,
    required this.secondName,
    required this.phoneNumber,
    required this.email,
    required this.amount,
    required this.message,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) =>
      _$DonationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonationModelToJson(this);
}