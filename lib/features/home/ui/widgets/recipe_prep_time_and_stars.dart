import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RecipePrepTimeAndStars extends StatelessWidget {
  const RecipePrepTimeAndStars({
    super.key,
    required this.prepTime,
    required this.stars,
  });

  final TimeOfDay prepTime;
  final int stars;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Prep Time:",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8.w),
        Text(
          prepTime.hour == 0
              ? "${prepTime.minute} mins"
              : "${prepTime.hour}:${prepTime.minute} hour${prepTime.hour > 1 ? 's' : ''}",
          style: TextStyle(fontSize: 18.sp),
        ),
        Icon(Icons.hourglass_bottom, size: 20.sp, color: Colors.black54),
        const Spacer(),
        Text(
          stars.toString(),
          style: TextStyle(fontSize: 18.sp),
          textAlign: TextAlign.right,
        ),
        Icon(Icons.star, size: 24.sp, color: Colors.yellow),
      ],
    );
  }
}
