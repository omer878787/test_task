import '../entities/workout_entity.dart';

abstract class DashboardRepository {
  Future<List<WorkoutEntity>> getWorkoutsForToday();
}
