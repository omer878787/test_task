import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/assets/app_assets.dart';
import 'package:test_task/core/widgets/app_svg.dart';
import 'package:test_task/features/dashboard/data/models/mood_steps.dart';
import 'package:test_task/features/mood/bloc/mood_bloc.dart';
import 'package:test_task/features/mood/bloc/mood_event.dart';
import 'package:test_task/features/mood/bloc/mood_state.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../widgets/mood_ring.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoodBloc>(),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 260, // adjust based on design
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2E4A6F), // bluish top
                  Color(0xFF0F1A26), // dark blue
                  Color(0xFF000000), // black bottom
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Mood",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w400, // Regular
                      height: 28.8 / 32, // = 0.9 (IMPORTANT)
                      letterSpacing: 0,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start your day",
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400, // Regular
                                height: 21.6 / 18, // = 1.2
                                letterSpacing: 0,
                                color: AppColors.textColor.withOpacity(0.85),
                              ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "How are you feeling at the\nMoment?",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600, // SemiBold
                                height: 1.2, // 120%
                                letterSpacing: 0,
                                color: AppColors.textColor,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Center(
                    child: BlocBuilder<MoodBloc, MoodState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            InteractiveMoodRing(
                              initialProgress: 0.75,
                              steps: [
                                MoodStep(
                                  from: 0.00,
                                  to: 0.25,
                                  label: "Sad",
                                  center: AppSvg(AppAssets.icSad),
                                ),
                                MoodStep(
                                  from: 0.25,
                                  to: 0.50,
                                  label: "Okay",
                                  center: AppSvg(AppAssets.icOkay),
                                ),
                                MoodStep(
                                  from: 0.50,
                                  to: 0.75,
                                  label: "Good",
                                  center: AppSvg(AppAssets.icHappy),
                                ),
                                MoodStep(
                                  from: 0.75,
                                  to: 1.01, // include 1.0
                                  label: "Calm",
                                  center: AppSvg(AppAssets.icClam),
                                ),
                              ],
                              onChanged: (p) {
                                context.read<MoodBloc>().add(
                                  MoodChanged(state.value),
                                );
                              },
                            ),

                            SizedBox(height: 14.h),
                          ],
                        );
                      },
                    ),
                  ),

                  const Spacer(),

                  PrimaryButton(text: "Continue", onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
