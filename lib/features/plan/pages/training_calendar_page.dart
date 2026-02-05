import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_card.dart';

class TrainingCalendarPage extends StatelessWidget {
  const TrainingCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Training Calendar",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  "Save",
                  style: TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Container(height: 2, color: AppColors.blue.withOpacity(0.7)),
            SizedBox(height: 14.h),

            Row(
              children: [
                Text(
                  "Week 2/8",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  "Total: 60min",
                  style: TextStyle(color: AppColors.subText, fontSize: 12.sp),
                ),
              ],
            ),
            Text(
              "December 8-14",
              style: TextStyle(color: AppColors.subText, fontSize: 12.sp),
            ),
            SizedBox(height: 14.h),

            Expanded(
              child: ListView(
                children: [
                  _dayRow(
                    "Mon",
                    "8",
                    label: "Arms Workout",
                    title: "Arm Blaster",
                    right: "25m - 30m",
                    color: AppColors.teal,
                  ),
                  _emptyDay("Tue", "9"),
                  _emptyDay("Wed", "10"),
                  _dayRow(
                    "Thu",
                    "11",
                    label: "Leg Workout",
                    title: "Leg Day Blitz",
                    right: "25m - 30m",
                    color: AppColors.blue,
                  ),
                  _emptyDay("Fri", "12"),
                  _emptyDay("Sat", "13"),
                  _emptyDay("Sun", "14"),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "Week 2",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Total: 60min",
                        style: TextStyle(
                          color: AppColors.subText,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "December 14-22",
                    style: TextStyle(color: AppColors.subText, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyDay(String d, String num) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(d, style: const TextStyle(color: AppColors.subText)),
          ),
          Text(num, style: const TextStyle(color: AppColors.subText)),
        ],
      ),
    );
  }

  Widget _dayRow(
    String d,
    String num, {
    required String label,
    required String title,
    required String right,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Text(d, style: const TextStyle(color: AppColors.subText)),
          ),
          SizedBox(
            width: 22,
            child: Text(num, style: const TextStyle(color: AppColors.subText)),
          ),
          Expanded(
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    right,
                    style: const TextStyle(
                      color: AppColors.subText,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
