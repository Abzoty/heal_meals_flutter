// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      notificationId: json['notification_id'] as String?,
      userId: json['user_id'] as String?,
      dateSent: json['dateSent'] == null
          ? null
          : DateTime.parse(json['dateSent'] as String),
      isRead: json['isRead'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'notification_id': instance.notificationId,
      'user_id': instance.userId,
      'dateSent': instance.dateSent?.toIso8601String(),
      'isRead': instance.isRead,
      'message': instance.message,
    };
