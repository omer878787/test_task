import '../../domain/entities/workout_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_local_ds.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDs localDs;
  DashboardRepositoryImpl({required this.localDs});

  @override
  Future<List<WorkoutEntity>> getWorkoutsForToday() =>
      localDs.getTodayWorkouts();
}
