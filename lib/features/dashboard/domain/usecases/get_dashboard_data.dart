import '../entities/workout_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardData {
  final DashboardRepository repo;
  GetDashboardData(this.repo);

  Future<List<WorkoutEntity>> call() => repo.getWorkoutsForToday();
}
