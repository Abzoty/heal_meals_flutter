import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: "notification_id")
  String? notificationId;
  @JsonKey(name: "user_id")
  String? userId;
  DateTime? dateSent;
  bool? isRead;
  String? message;

  NotificationModel({
    this.notificationId,
    this.userId,
    this.dateSent,
    this.isRead,
    this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
  

  NotificationModel copyWith({
    String? notificationId,
    String? userId,
    DateTime? dateSent,
    bool? isRead,
    String? message,
  }) {
    return NotificationModel(
      notificationId: notificationId ?? this.notificationId,
      userId: userId ?? this.userId,
      dateSent: dateSent ?? this.dateSent,
      isRead: isRead ?? this.isRead,
      message: message ?? this.message,
    );
  }
}