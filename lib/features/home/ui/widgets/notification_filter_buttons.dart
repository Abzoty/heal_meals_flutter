import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:heal_meals/features/home/logic/cubit/notification_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationFilterButtons extends StatelessWidget {
  const NotificationFilterButtons({super.key});

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
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final isUnreadSelected = state is NotificationUnreadLoaded;

        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  context.read<NotificationCubit>().getAllNotifications(
                    await _getUserEmail(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: !isUnreadSelected
                        ? Colors.grey.shade300
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                  ),
                  child: Text(
                    'All',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: !isUnreadSelected
                          ? Colors.black
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  context.read<NotificationCubit>().getUnreadNotifications(
                    await _getUserEmail(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isUnreadSelected
                        ? const Color(0xFF2E7D32)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isUnreadSelected
                          ? const Color(0xFF2E7D32)
                          : Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Unread',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isUnreadSelected
                          ? Colors.white
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
