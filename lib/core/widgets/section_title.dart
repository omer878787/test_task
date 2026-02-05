import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionTitle(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            height: 28.8 / 24, // = 1.2
            letterSpacing: 0,
          ),
        ),
        const Spacer(),
        ?trailing,
      ],
    );
  }
}
