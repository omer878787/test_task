import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/assets/app_assets.dart';
import 'package:test_task/core/widgets/app_svg.dart';
import '../theme/app_colors.dart';

class DeltaPill extends StatelessWidget {
  final String text; // "+1.6kg"
  final bool isUp; // true => up, false => down
  final Color? color; // optional override

  const DeltaPill({
    super.key,
    required this.text,
    this.isUp = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.teal; // your green

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18.w,
          height: 18.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: c.withValues(alpha: 0.20), // soft bg like screenshot
          ),
          child: isUp ? AppSvg(AppAssets.icUp) : AppSvg(AppAssets.icUp),
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: AppColors.subText, // in screenshot text looks muted
          ),
        ),
      ],
    );
  }
}
