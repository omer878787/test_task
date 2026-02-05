import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/features/dashboard/presentation/bloc/clander_cubit/calendar_cubit.dart';
import '../theme/app_colors.dart';

class CalendarWeekPager extends StatefulWidget {
  final int weeksBefore;
  final int weeksAfter;

  const CalendarWeekPager({
    super.key,
    this.weeksBefore = 12,
    this.weeksAfter = 12,
  });

  @override
  State<CalendarWeekPager> createState() => _CalendarWeekPagerState();
}

class _CalendarWeekPagerState extends State<CalendarWeekPager> {
  late final PageController _pc;

  int get _initialPage => widget.weeksBefore;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<CalendarCubit>();
    _pc = PageController(initialPage: cubit.state.pageIndex);
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  DateTime _startOfWeekSunday(DateTime d) {
    final sundayIndex = d.weekday % 7; // Sun=0, Mon=1..Sat=6
    final onlyDate = DateTime(d.year, d.month, d.day);
    return onlyDate.subtract(Duration(days: sundayIndex));
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    const labels = [
      "M",
      "TU",
      "W",
      "TH",
      "F",
      "SA",
      "SU",
    ]; // match your screenshot order
    final totalPages = widget.weeksBefore + widget.weeksAfter + 1;

    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final weekStart = _startOfWeekSunday(state.selectedDate);

        return Column(
          children: [
            SizedBox(
              height: 100.h,
              child: PageView.builder(
                controller: _pc,
                itemCount: totalPages,
                onPageChanged: (i) => context.read<CalendarCubit>().setPage(i),
                itemBuilder: (context, index) {
                  final weekOffset = index - _initialPage;
                  final start = weekStart.add(Duration(days: weekOffset * 7));

                  // Build as Mon..Sun (like screenshot)
                  final days = List.generate(
                    7,
                    (i) => start.add(Duration(days: i + 1)),
                  )..[6] = start; // put Sunday at end

                  return Row(
                    children: List.generate(7, (i) {
                      final d = days[i];
                      final isSel = _isSameDay(d, state.selectedDate);

                      return Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              context.read<CalendarCubit>().selectDate(d),
                          child: Column(
                            children: [
                              Text(
                                labels[i],
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      height:
                                          14.4 / 12, // line-height ÷ font-size
                                      letterSpacing: 0,
                                    ),
                              ),
                              SizedBox(height: 12.h),
                              Container(
                                width: 36.w,
                                height: 36.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSel
                                      ? AppColors.teal.withValues(alpha: 0.19)
                                      : AppColors.bgColorCircle,
                                  border: Border.all(
                                    width: 2,
                                    color: isSel
                                        ? AppColors.teal
                                        : Colors.transparent,
                                  ),
                                ),
                                child: Text(
                                  "${d.day}",

                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        height:
                                            16.8 /
                                            14, // line-height ÷ font-size
                                        letterSpacing: 0,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // ✅ green dot under selected date
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 160),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSel
                                      ? AppColors.teal
                                      : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // ✅ pill indicator
            SizedBox(
              height: 6,
              child: Center(
                child: _PillIndicator(
                  progress: (state.pageIndex / (totalPages - 1)).clamp(
                    0.0,
                    1.0,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PillIndicator extends StatelessWidget {
  final double progress;
  const _PillIndicator({required this.progress});

  @override
  Widget build(BuildContext context) {
    const trackW = 60.0;
    const knobW = 26.0;

    return SizedBox(
      width: trackW,
      child: Stack(
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D36),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          Positioned(
            left: (trackW - knobW) * progress,
            child: Container(
              width: knobW,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF5A5E6C),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
