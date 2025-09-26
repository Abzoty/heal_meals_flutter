part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}

class NotificationAllLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  const NotificationAllLoaded(this.notifications);
  @override
  List<Object> get props => [notifications];
}

class NotificationUnreadLoaded extends NotificationState {
  final List<NotificationModel> notifications;
  const NotificationUnreadLoaded(this.notifications);
  @override
  List<Object> get props => [notifications];
}

class NotificationMarkAsRead extends NotificationState {
  final NotificationModel notification;
  const NotificationMarkAsRead(this.notification);
  @override
  List<Object> get props => [notification];
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
  @override
  List<Object> get props => [message];
}
