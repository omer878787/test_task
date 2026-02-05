import '../../domain/entities/workout_entity.dart';

class DashboardLocalDs {
  Future<List<WorkoutEntity>> getTodayWorkouts() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      WorkoutEntity(
        title: "Upper Body",
        subtitle: "December 22 · 25m – 30m",
        minutes: 30,
      ),
    ];
  }
}
