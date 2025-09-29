import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              padding: EdgeInsets.all(20.0.sp),
              child: Column(
                children: [
                  // Bell Icon
                  _NotificationHeader(),
                  SizedBox(height: 20.h),
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
                      return Center(
                        child: Text(
                          'No notifications found',
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          notification: notifications[index],
                        );
                      },
                    );
                  } else if (state is NotificationError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.sp,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${state.message}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
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
        SizedBox(height: 16.h),

        // top row with stack
        Stack(
          alignment: Alignment.center,
          children: [
            // back button aligned left
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 24.sp),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
            ),

            // notification icon centered
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10.r,
                    offset: Offset(0.w, 2.h),
                  ),
                ],
              ),
              child: Icon(
                Icons.notifications_outlined,
                size: 30.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        Text(
          'Notifications',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
