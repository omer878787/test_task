import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class CalendarWeekStrip extends StatelessWidget {
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;

  const CalendarWeekStrip({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final start = selected.subtract(Duration(days: selected.weekday % 7));
    final days = List.generate(7, (i) => start.add(Duration(days: i)));

    return Row(
      children: days.map((d) {
        final isSel =
            d.year == selected.year &&
            d.month == selected.month &&
            d.day == selected.day;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(d),
            child: Column(
              children: [
                Text(
                  DateFormat.E().format(d).toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.subText,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSel ? AppColors.teal : AppColors.stroke,
                    ),
                    color: isSel
                        ? AppColors.teal.withOpacity(0.15)
                        : Colors.transparent,
                  ),
                  child: Text(
                    "${d.day}",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
