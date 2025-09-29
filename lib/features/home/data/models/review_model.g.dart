// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  userId: json['userId'] as String?,
  recipeId: json['recipeId'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  comment: json['comment'] as String?,
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'recipeId': instance.recipeId,
      'rating': instance.rating,
      'comment': instance.comment,
    };
