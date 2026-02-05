import 'package:get_it/get_it.dart';
import 'package:test_task/features/dashboard/presentation/bloc/clander_cubit/calendar_cubit.dart';
import 'package:test_task/features/mood/bloc/mood_bloc.dart';

import '../../features/dashboard/data/datasources/dashboard_local_ds.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_data.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Data sources
  sl.registerLazySingleton<DashboardLocalDs>(() => DashboardLocalDs());

  // Repos
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(localDs: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => GetDashboardData(sl()));

  // Blocs
  sl.registerFactory(() => DashboardBloc(getDashboardData: sl()));
  sl.registerFactory(() => MoodBloc());
  sl.registerFactory(
    () => CalendarCubit(initialDate: DateTime.now(), initialPageIndex: 12),
  );
}
