// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConditionModel _$UserConditionModelFromJson(Map<String, dynamic> json) =>
    UserConditionModel(
      userConditionId: json['id'] as String,
      conditionId: json['conditionId'] as String,
      userConditionName: json['conditionName'] as String,
    );

Map<String, dynamic> _$UserConditionModelToJson(UserConditionModel instance) =>
    <String, dynamic>{
      'id': instance.userConditionId,
      'conditionId': instance.conditionId,
      'conditionName': instance.userConditionName,
    };
