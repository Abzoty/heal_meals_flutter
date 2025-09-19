// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationModel _$DonationModelFromJson(Map<String, dynamic> json) =>
    DonationModel(
      firstName: json['firstName'] as String,
      secondName: json['secondName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      amount: (json['amount'] as num).toDouble(),
      message: json['message'] as String,
      cardNumber: json['cardNumber'] as String,
      expiryDate: json['expiryDate'] as String,
      cvv: json['cvv'] as String,
    );

Map<String, dynamic> _$DonationModelToJson(DonationModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'amount': instance.amount,
      'message': instance.message,
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
    };
