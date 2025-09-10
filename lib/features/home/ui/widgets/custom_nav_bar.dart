import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomNavBar extends StatelessWidget {
  final String currentPage;

  const CustomNavBar({super.key, required this.currentPage});

  final List<_NavItem> _items = const [
    _NavItem(icon: Icons.home, label: "home", route: '/home'),
    _NavItem(
      icon: Icons.volunteer_activism,
      label: "donation",
      route: '/donation',
    ),
    _NavItem(icon: Icons.explore, label: "discover", route: '/discover'),
    _NavItem(icon: Icons.bookmark, label: "favorites", route: '/favorites'),
    _NavItem(icon: Icons.account_circle, label: "profile", route: '/profile'),
  ];

  void _onItemTapped(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name == route) return;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Color(0xFF2D995D), Color(0xFF1C7C54), Color(0xFF1B512D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: _items.map((item) {
          final isSelected =
              item.label.toLowerCase() == currentPage.toLowerCase();

          return Expanded(
            child: GestureDetector(
              onTap: () => _onItemTapped(context, item.route),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : null,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: Colors.white,
                      size: isSelected ? 22.sp : 26.sp,
                    ),
                    if (isSelected) ...[
                      SizedBox(height: 2.h),
                      Text(
                        item.label,
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
