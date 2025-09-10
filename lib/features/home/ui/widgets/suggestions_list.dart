import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestionsList extends StatelessWidget {
  final bool visible;
  final List<String> suggestions;
  final ValueChanged<String> onTapSuggestion;
  final double maxHeight;

  const SuggestionsList({
    super.key,
    required this.visible,
    required this.suggestions,
    required this.onTapSuggestion,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight.h),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final s = suggestions[index];
            return InkWell(
              onTap: () => onTapSuggestion(s),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 10.r,
                  horizontal: 12.r,
                ),
                margin: EdgeInsets.only(bottom: 6.r),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

