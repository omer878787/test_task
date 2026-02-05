import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/assets/app_assets.dart';
import 'package:test_task/core/widgets/app_svg.dart';
import '../theme/app_colors.dart';

class WorkoutCard extends StatelessWidget {
  final String subtitle;
  final String title;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.subtitle,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 8.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: AppColors.card),
            color: AppColors.card,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Row(
              children: [
                // ✅ LEFT STRIP (flush + full height)
                Container(
                  width: 8.w,
                  height: 100.h, // adjust 8-12 as per design
                  //padding: EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.cardLeftColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      bottomLeft: Radius.circular(radius),
                    ),
                  ),
                ),

                // content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                height: 14.4 / 12, // = 1.2
                                letterSpacing: 0,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                height: 28.8 / 24, // = 1.2
                                letterSpacing: -0.48, // ✅ -2%
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: AppSvg(AppAssets.icArrow),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
