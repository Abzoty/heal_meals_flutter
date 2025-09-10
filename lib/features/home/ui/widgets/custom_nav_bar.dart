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
      height: 67.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Color(0xFF2D995D), Color(0xFF1C7C54), Color(0xFF1B512D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items.map((item) {
            final isSelected =
                item.label.toLowerCase() == currentPage.toLowerCase();

            return GestureDetector(
              onTap: () => _onItemTapped(context, item.route),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.icon, color: Colors.white, size: 22.sp),
                    if (isSelected)
                      Text(
                        item.label,
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
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
