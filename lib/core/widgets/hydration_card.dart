import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import 'hydration_scale.dart';

class HydrationCard extends StatelessWidget {
  final int percentage; // 0
  final int currentMl; // 0
  final int maxMl; // 2000
  final int addedMl; // 500

  const HydrationCard({
    super.key,
    required this.percentage,
    required this.currentMl,
    this.maxMl = 2000,
    required this.addedMl,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.card),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LEFT SIDE
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$percentage%",
                          style: t.displaySmall?.copyWith(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.0, // 100% line-height
                            letterSpacing: 0,
                            color: AppColors.inActiveScaleColor,
                          ),
                        ),
                        SizedBox(height: 43.h),
                        Text(
                          "Hydration",
                          style: t.titleMedium?.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            letterSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "Log Now",
                          style: t.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subText,
                            height: 1.2,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // RIGHT SIDE SCALE
                  HydrationScale(currentMl: 0),
                ],
              ),
            ),

            // BOTTOM BAR
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                color: AppColors.cardBottomColor, // teal dark strip
              ),
              child: Text(
                "$addedMl ml added to water log",
                textAlign: TextAlign.center,
                style: t.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400, // Regular
                  height: 1.2,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
