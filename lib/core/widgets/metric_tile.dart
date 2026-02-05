import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import 'glass_card.dart';

class MetricTile extends StatelessWidget {
  final String big; // "550"
  final String label; // "Calories"
  final Widget? sub; // "1950 Remaining"

  final double progress; // 0..1
  final String minLabel; // "0"
  final String maxLabel; // "2500"
  final bool showProgress;
  final String? bottomLabel;
  const MetricTile({
    super.key,
    required this.big,
    required this.label,
    this.sub,
    required this.progress,
    this.minLabel = "0",
    this.bottomLabel,
    this.showProgress = true,
    this.maxLabel = "2500",
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return GlassCard(
      padding: EdgeInsets.all(14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ 550 Calories on one baseline
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                big,
                style: t.displaySmall?.copyWith(
                  fontSize: 40.sp, // close to screenshot
                  fontWeight: FontWeight.w600, // 600
                  height: 1.0, // 100%
                  letterSpacing: 0,
                ),
              ),
              SizedBox(width: 2.w),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 6.h,
                ), // align with big number baseline
                child: Text(
                  label,
                  style: t.titleMedium?.copyWith(
                    fontSize:
                        16.sp, // looks a bit smaller than 18 in screenshot
                    fontWeight: FontWeight.w700, // bold
                    height: 1.2,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // ✅ subtitle uses theme (Mulish preserved)
          sub ??
              Text(
                '1950 Remaining',
                style: t.bodySmall?.copyWith(
                  color: AppColors.subText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),

          SizedBox(height: 14.h),

          // ✅ min/max labels
          showProgress
              ? Row(
                  children: [
                    Text(
                      minLabel,
                      style: t.bodySmall?.copyWith(
                        color: AppColors.subText.withOpacity(0.75),
                        fontSize: 12.sp,
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      maxLabel,
                      style: t.bodySmall?.copyWith(
                        color: AppColors.subText.withOpacity(0.75),
                        fontSize: 12.sp,
                        height: 1.2,
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),

          SizedBox(height: 8.h),

          // ✅ progress bar
          showProgress
              ? _ProgressBar(value: progress)
              : Text(
                  bottomLabel ?? '',
                  style: t.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    height: 21.6 / 18, // = 1.2
                    letterSpacing: 0,
                  ),
                ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value; // 0..1
  const _ProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: Container(
        height: 8.h,
        color: AppColors.stroke,
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: v,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF7BBDE2),
                    Color(0xFF69C0B1),
                    Color(0xFF60C198),
                  ],
                ),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
