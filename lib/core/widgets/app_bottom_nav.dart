import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/assets/app_assets.dart';
import 'package:test_task/core/widgets/app_svg.dart';
import '../theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.stroke)),
        color: AppColors.bg,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.bg,
        selectedItemColor: AppColors.textColor, // still fine
        unselectedItemColor: AppColors.subText,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: _navItem(
              context: context,
              index: 0,
              label: 'Nutrition',
              iconAsset: AppAssets.icNut,
              currentIndex: currentIndex,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navItem(
              context: context,
              index: 1,
              label: 'Plan',
              currentIndex: currentIndex,
              iconAsset: AppAssets.icPlan,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navItem(
              context: context,
              index: 2,
              label: 'Mood',
              currentIndex: currentIndex,
              iconAsset: AppAssets.icMood,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _navItem(
              context: context,
              index: 3,
              currentIndex: currentIndex,
              label: 'Profile',
              iconAsset: AppAssets.icProfile,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}

Widget _navItem({
  required BuildContext context,
  required int index,
  required String label,
  required String iconAsset,
  required int currentIndex,
}) {
  final isActive = currentIndex == index;

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AppSvg(
        iconAsset,
        color: isActive ? AppColors.textColor : AppColors.inActiveNavText,
      ),
      SizedBox(height: 4.h),
      Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: 1.2,
          letterSpacing: 0,
          color: isActive
              ? AppColors
                    .textColor // ✅ active
              : AppColors.inActiveNavText, // ✅ inactive
        ),
      ),
    ],
  );
}
