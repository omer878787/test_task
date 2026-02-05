import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarState extends Equatable {
  final DateTime selectedDate;
  final int pageIndex;

  const CalendarState({required this.selectedDate, required this.pageIndex});

  factory CalendarState.initial({
    DateTime? initialDate,
    int initialPageIndex = 12,
  }) {
    return CalendarState(
      selectedDate: initialDate ?? DateTime.now(),
      pageIndex: initialPageIndex,
    );
  }

  CalendarState copyWith({DateTime? selectedDate, int? pageIndex}) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object?> get props => [selectedDate, pageIndex];
}

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({DateTime? initialDate, int initialPageIndex = 12})
    : super(
        CalendarState.initial(
          initialDate: initialDate,
          initialPageIndex: initialPageIndex,
        ),
      );

  void selectDate(DateTime d) => emit(state.copyWith(selectedDate: d));

  void setPage(int index) => emit(state.copyWith(pageIndex: index));
}
