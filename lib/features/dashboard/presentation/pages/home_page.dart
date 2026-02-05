import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task/core/assets/app_assets.dart';
import 'package:test_task/core/widgets/app_svg.dart';
import 'package:test_task/core/widgets/calendar_week_pager.dart';
import 'package:test_task/core/widgets/delta_pill.dart';
import 'package:test_task/core/widgets/hydration_card.dart';
import 'package:test_task/core/widgets/workout_card.dart';
import 'package:test_task/features/dashboard/presentation/bloc/clander_cubit/calendar_cubit.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/calendar_week_strip.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/metric_tile.dart';
import '../../../../core/widgets/section_title.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selected = DateTime(2024, 12, 22);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<DashboardBloc>()..add(const DashboardStarted()),
        ),
        BlocProvider(create: (_) => sl<CalendarCubit>()),
      ],
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppSvg(AppAssets.icBell),
                  ),
                  // CENTER: clock + Week 1/4 + caret
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSvg(AppAssets.icAccessTime),
                      SizedBox(width: 6.w),
                      Text(
                        "Week 1/4",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 16.8 / 14, // line-height ÷ font-size
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      AppSvg(AppAssets.icKeyBoardDropDown),
                    ],
                  ),
                ],
              ),

              // top row
              SizedBox(height: 24.h),
              Text(
                "Today, 22 Dec 2024",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 19.2 / 16, // = 1.2
                  letterSpacing: 0,
                ),
              ),
              SizedBox(height: 16.h),

              CalendarWeekPager(),

              SizedBox(height: 24.h),

              // Workouts
              SectionTitle(
                'Workouts',
                trailing: Row(
                  children: [
                    AppSvg(AppAssets.icSnowy),
                    SizedBox(width: 6.w),
                    Text(
                      '9°',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500, // ✅ Medium
                            height: 28.8 / 24, // ✅ 1.2
                            letterSpacing: 0,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const GlassCard(
                      child: SizedBox(
                        height: 64,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                  if (state.error != null) {
                    return GlassCard(
                      child: Text(
                        "Error: ${state.error}",
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }

                  final w = state.workouts.isNotEmpty
                      ? state.workouts.first
                      : null;

                  return WorkoutCard(
                    subtitle: w?.subtitle ?? '',
                    title: w?.title ?? '',
                    onTap: () {},
                  );
                },
              ),

              SizedBox(height: 32.h),

              // Insights
              const SectionTitle("My Insights"),
              SizedBox(height: 24.h),

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: MetricTile(
                            big: "550",
                            label: "Calories",
                            progress: 0.32, // adjust
                            minLabel: "0",
                            maxLabel: "2500",
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: MetricTile(
                            big: "75",
                            label: "Kg",
                            progress: 0.32, // adjust
                            minLabel: "+1.6kg",
                            bottomLabel: 'Weight',
                            showProgress: false,
                            sub: DeltaPill(text: "+1.6kg", isUp: true),
                            maxLabel: "2500",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    HydrationCard(percentage: 0, currentMl: 0, addedMl: 500),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
