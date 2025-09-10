import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: active ? Color(0xFF1B512D) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: active ? Colors.white : Colors.black87),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
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

