import 'package:json_annotation/json_annotation.dart';

part 'user_condition_model.g.dart';

@JsonSerializable()
class UserConditionModel {
  @JsonKey(name: 'id')
  final String userConditionId;
  final String conditionId;
  @JsonKey(name: 'conditionName')
  final String userConditionName;

  UserConditionModel({
    required this.userConditionId,
    required this.conditionId,
    required this.userConditionName,
  });

  factory UserConditionModel.fromJson(Map<String, dynamic> json) =>
      _$UserConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserConditionModelToJson(this);
}
