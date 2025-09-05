import 'package:flutter/material.dart';
import "../pages/health_profile_page.dart" show FilterMode; // import the enum

class FilterButtonsRow extends StatelessWidget {
  final FilterMode current;
  final ValueChanged<FilterMode> onChanged;

  const FilterButtonsRow({
    super.key,
    required this.current,
    required this.onChanged,
  });

  Widget _buildFilterButton({
    required IconData icon,
    required String label,
    required FilterMode mode,
    required BuildContext context,
  }) {
    final active = current == mode;
    return GestureDetector(
      onTap: () => onChanged(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: active ? Colors.green[700] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: active ? Colors.white : Colors.black87),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterButton(
          icon: Icons.list,
          label: 'All',
          mode: FilterMode.all,
          context: context,
        ),
        _buildFilterButton(
          icon: Icons.spa,
          label: 'Allergies',
          mode: FilterMode.allergies,
          context: context,
        ),
        _buildFilterButton(
          icon: Icons.local_hospital,
          label: 'Diseases',
          mode: FilterMode.diseases,
          context: context,
        ),
      ],
    );
  }
}
