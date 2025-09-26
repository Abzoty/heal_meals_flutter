import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/health_profile_page.dart';

class FilterButtonsRow extends StatelessWidget {
  final FilterMode current;
  final ValueChanged<FilterMode> onChanged;

  const FilterButtonsRow({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FilterButton(
            label: 'All',
            isSelected: current == FilterMode.all,
            onTap: () => onChanged(FilterMode.all),
          ),

          _FilterButton(
            label: 'Allergies',
            isSelected: current == FilterMode.allergies,
            onTap: () => onChanged(FilterMode.allergies),
          ),

          _FilterButton(
            label: 'Diseases',
            isSelected: current == FilterMode.diseases,
            onTap: () => onChanged(FilterMode.diseases),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B512D) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF1B512D) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontSize: 18.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
