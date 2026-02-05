import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../domain/usecases/get_dashboard_data.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardData getDashboardData;

  DashboardBloc({required this.getDashboardData})
    : super(DashboardState.initial()) {
    on<DashboardStarted>((event, emit) async {
      try {
        emit(state.copyWith(loading: true, error: null));
        final workouts = await getDashboardData();
        emit(state.copyWith(loading: false, workouts: workouts));
      } catch (e) {
        emit(state.copyWith(loading: false, error: e.toString()));
      }
    });
  }
}
