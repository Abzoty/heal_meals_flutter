import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/features/home/data/models/notification_model.dart';
import 'package:heal_meals/features/home/data/repositories/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;

  NotificationCubit({required NotificationRepo notificationRepo})
    : _notificationRepo = notificationRepo,
      super(NotificationInitial());

  Future<void> getAllNotifications(String email) async {
    emit(NotificationLoading());
    final result = await _notificationRepo.getAllNotifications(email);
    result.when(
      success: (notifications) => emit(NotificationAllLoaded(notifications)),
      error: (e) => emit(NotificationError(e)),
    );
  }

  Future<void> getUnreadNotifications(String email) async {
    emit(NotificationLoading());
    final result = await _notificationRepo.getUnreadNotifications(email);
    result.when(
      success: (notifications) =>
          emit(NotificationUnreadLoaded(notifications)),
      error: (e) => emit(NotificationError(e)),
    );
  }

Future<void> markNotificationAsRead(
    String notificationId,
    String email, {
    bool reloadUnread = false,
  }) async {
    emit(NotificationLoading());
    final result = await _notificationRepo.markNotificationAsRead(
      notificationId,
    );
    result.when(
      success: (_) {
        if (reloadUnread) {
          getUnreadNotifications(email);
        } else {
          getAllNotifications(email);
        }
      },
      error: (e) => emit(NotificationError(e)),
    );
  }


}
