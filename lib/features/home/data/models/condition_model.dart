import 'package:json_annotation/json_annotation.dart';

part 'condition_model.g.dart';

@JsonSerializable()
class ConditionModel {
  final String conditionId;
  final String conditionName;
  final String conditionType;

  ConditionModel(this.conditionType, {required this.conditionId, required this.conditionName});

  factory ConditionModel.fromJson(Map<String, dynamic> json) =>
      _$ConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionModelToJson(this);
}
