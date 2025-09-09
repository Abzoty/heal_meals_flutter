import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final String currentPage; // Pass the name of the current page

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
    if (ModalRoute.of(context)?.settings.name == route) {
      return; // Avoid reloading same page
    }
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Color(0xFF1B512D), // dark green background
        gradient: LinearGradient(
          colors: [Color(0xFF2D995D), Color(0xFF1C7C54), Color(0xFF1B512D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items.map((item) {
            // Highlight only if the currentPage matches one of the 5 labels
            final isSelected =
                item.label.toLowerCase() == currentPage.toLowerCase();

            return GestureDetector(
              onTap: () => _onItemTapped(context, item.route),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.icon, color: Colors.white),
                    if (isSelected)
                      Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
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
