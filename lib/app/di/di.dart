import 'package:clean_ease/core/network/hive_service.dart';
import 'package:clean_ease/features/auth/data/repository/auth_local_repository.dart';
import 'package:clean_ease/features/auth/domain/use_case/login_usecase.dart';
import 'package:clean_ease/features/auth/domain/use_case/register_usecase.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Hive Service
  _initHiveService();

  // Initialize Auth Dependencies
  _initAuthDependencies();

  // Initialize Home Dependencies
  _initHomeDependencies();
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initAuthDependencies() {
  // Auth Local Data Source
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(getIt<HiveService>()));

  // Auth Repository
  getIt.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepository(getIt<AuthLocalDataSource>()));

  // Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(getIt<AuthLocalRepository>()));
  getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthLocalRepository>()));

  // Login Bloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: getIt<LoginUseCase>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );

  // Register Bloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
    ),
  );
}

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
