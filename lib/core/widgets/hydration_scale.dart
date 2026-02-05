import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class HydrationScale extends StatelessWidget {
  final int currentMl;
  final int maxMl;

  const HydrationScale({super.key, required this.currentMl, this.maxMl = 2000});

  static const int _tickCount = 9;

  @override
  Widget build(BuildContext context) {
    const int tickCount = 9;

    final ratio = maxMl == 0 ? 0.0 : (currentMl / maxMl).clamp(0.0, 1.0);

    final activeIndex = ((tickCount - 1) * ratio).floor().clamp(
      0,
      tickCount - 1,
    );
    final t = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // SCALE + LABELS
        SizedBox(
          height: 151.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "2L",
                style: t.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600, // SemiBold
                  height: 1.2,

                  color: AppColors.textColorNew,
                  letterSpacing: 0,
                ),
              ),

              _Ticks(activeIndex: activeIndex),

              Text(
                "0L",
                style: t.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600, // SemiBold
                  height: 1.2,

                  color: AppColors.textColorNew,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),

        //SizedBox(width: 10.w),

        // LINE + VALUE (aligned with active tick)
        _ActiveLine(activeIndex: activeIndex, currentMl: currentMl),
      ],
    );
  }
}

class _ActiveLine extends StatelessWidget {
  final int activeIndex;
  final int currentMl;

  const _ActiveLine({required this.activeIndex, required this.currentMl});

  @override
  Widget build(BuildContext context) {
    const int tickCount = 9;

    // total height taken by ticks column
    final ticksHeight = 70.h;
    final gap = ticksHeight / (tickCount - 1);

    // active tick Y position (from top of ticks)
    final activeOffsetFromTop = ticksHeight - (activeIndex * gap);

    return SizedBox(
      height: 120.h,
      width: 130.w,
      child: Stack(
        children: [
          // horizontal active line (blue)
          Positioned(
            top: 27.h + activeOffsetFromTop - 1.h, // 24 = space for "2L"
            left: 0,
            right: 40.w,
            child: Container(height: 1.h, color: AppColors.lineColor),
          ),
          // value text
          Positioned(
            top: 30.h + activeOffsetFromTop - 15.h,
            left: 90,
            child: Text(
              "${currentMl}ml",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600, // SemiBold
                height: 1.2,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Ticks extends StatelessWidget {
  final int activeIndex;

  const _Ticks({required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    const int tickCount = 9;
    final mid = tickCount ~/ 2; // 4 for 9 ticks
    return SizedBox(
      height: 109.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(tickCount, (i) {
          // Your current mapping: activeIndex=0 => bottom, activeIndex=8 => top
          final activeRow = tickCount - 1 - activeIndex;
          final isActive = i == activeRow;

          // Major ticks: top (i=0), middle (i=mid), bottom (i=tickCount-1)
          final isMajor = (i == 0) || (i == mid) || (i == tickCount - 1);

          final width = (isActive || isMajor) ? 10.w : 6.w;
          final height = (isActive || isMajor) ? 4.h : 2.h;

          return Container(
            width: width,
            height: height,

            decoration: BoxDecoration(
              color: isMajor
                  ? AppColors.inActiveScaleColor
                  : AppColors.inActiveScaleColor.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(isMajor ? 4 : 2),
            ),
          );
        }),
      ),
    );
  }
}
