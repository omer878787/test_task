import 'package:equatable/equatable.dart';
import '../../domain/entities/workout_entity.dart';

class DashboardState extends Equatable {
  final bool loading;
  final String? error;
  final List<WorkoutEntity> workouts;

  const DashboardState({
    required this.loading,
    required this.workouts,
    this.error,
  });

  factory DashboardState.initial() =>
      const DashboardState(loading: true, workouts: []);

  DashboardState copyWith({
    bool? loading,
    String? error,
    List<WorkoutEntity>? workouts,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      error: error,
      workouts: workouts ?? this.workouts,
    );
  }

  @override
  List<Object?> get props => [loading, error, workouts];
}
