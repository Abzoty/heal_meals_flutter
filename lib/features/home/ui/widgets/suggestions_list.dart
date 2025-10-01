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
    if (!visible || suggestions.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: suggestions.length,
          separatorBuilder: (context, index) => SizedBox(height: 4.h),
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onTapSuggestion(suggestion),
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.green[200]!, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 18.sp, color: Colors.green[700]),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          suggestion,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14.sp,
                        color: Colors.green[600],
                      ),
                    ],
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
