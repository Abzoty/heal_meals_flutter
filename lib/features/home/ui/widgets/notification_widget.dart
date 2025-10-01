import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:heal_meals/features/home/data/models/notification_model.dart';
import 'package:heal_meals/features/home/logic/cubit/notification_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({super.key, required this.notification});

  Future<String> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return '';
    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    final user = UserProfileModel.fromJson(userMap);
    return user.email;
  }

  @override
  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRead
            ? Colors.grey.shade50
            : Colors.white, // More distinct for unread
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRead
              ? Colors.grey.shade200
              : const Color(0xFF2E7D32), // Green border for unread
          width: isRead ? 0.5 : 1.5, // Thicker border for unread
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isRead ? 0.03 : 0.08,
            ), // Slightly more shadow for unread
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Read status indicator dot
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isRead
                  ? Colors.transparent
                  : const Color(0xFF2E7D32), // Only show dot for unread
            ),
          ),
          const SizedBox(width: 12),

          // Message Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.message ?? 'No message',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isRead
                        ? FontWeight.w400
                        : FontWeight.w600, // Bold for unread
                    color: isRead
                        ? Colors.grey.shade700
                        : Colors.black87, // Different color
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatDate(notification.dateSent),
                  style: TextStyle(
                    fontSize: 11,
                    color: isRead ? Colors.grey.shade500 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Read/Unread Button
          GestureDetector(
            onTap: () async {
              if (!isRead && notification.notificationId != null) {
                context.read<NotificationCubit>().markNotificationAsRead(
                  notification.notificationId!,
                  await _getUserEmail(),
                  reloadUnread: false,
                );
              }
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isRead
                    ? Colors.grey.shade300
                    : const Color(0xFF2E7D32).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isRead
                      ? Colors.grey.shade400
                      : const Color(0xFF2E7D32),
                ),
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: isRead ? Colors.grey.shade600 : const Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown date';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')} - '
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
  }
}
