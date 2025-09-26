import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:heal_meals/features/home/logic/cubit/notification_cubit.dart';
import 'package:heal_meals/features/home/ui/widgets/notification_filter_buttons.dart';
import 'package:heal_meals/features/home/ui/widgets/notification_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  Future<String> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return '';
    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    final user = UserProfileModel.fromJson(userMap);
    return user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: const [
                  // Bell Icon
                  _NotificationHeader(),
                  SizedBox(height: 20),
                  // Filter Buttons
                  NotificationFilterButtons(),
                ],
              ),
            ),
            // Notifications List
            Expanded(
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2E7D32),
                      ),
                    );
                  } else if (state is NotificationAllLoaded ||
                      state is NotificationUnreadLoaded) {
                    // Get notifications from the correct state
                    final notifications = state is NotificationAllLoaded
                        ? state.notifications
                        : (state as NotificationUnreadLoaded).notifications;

                    if (notifications.isEmpty) {
                      return const Center(
                        child: Text(
                          'No notifications found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          notification: notifications[index],
                        );
                      },
                    );
                  }  else if (state is NotificationError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${state.message}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              context
                                  .read<NotificationCubit>()
                                  .getAllNotifications(await _getUserEmail());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationHeader extends StatelessWidget {
  const _NotificationHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
