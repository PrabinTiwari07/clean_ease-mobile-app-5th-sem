// import 'package:clean_ease/core/network/hive_service.dart';
// import 'package:clean_ease/features/auth/data/repository/auth_local_repository.dart';
// import 'package:clean_ease/features/auth/domain/use_case/login_usecase.dart';
// import 'package:clean_ease/features/auth/domain/use_case/register_usecase.dart';
// import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
// import 'package:get_it/get_it.dart';

// import '../../features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
// import '../../features/auth/presentation/view_model/login/login_bloc.dart';

// final getIt = GetIt.instance;

// Future<void> initDependencies() async {
//   _initHiveService();

//   _initAuthDependencies();

//   _initHomeDependencies();
// }

// void _initHiveService() {
//   getIt.registerLazySingleton<HiveService>(() => HiveService());
// }

// void _initAuthDependencies() {
//   // Auth Local Data Source
//   getIt.registerLazySingleton<AuthLocalDataSource>(
//       () => AuthLocalDataSource(getIt<HiveService>()));

//   // Auth Repository
//   getIt.registerLazySingleton<AuthLocalRepository>(
//       () => AuthLocalRepository(getIt<AuthLocalDataSource>()));

//   // Use Cases
//   getIt.registerLazySingleton<LoginUseCase>(
//       () => LoginUseCase(getIt<AuthLocalRepository>()));
//   getIt.registerLazySingleton<RegisterUseCase>(
//       () => RegisterUseCase(getIt<AuthLocalRepository>()));

//   // Login Bloc
//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       loginUseCase: getIt<LoginUseCase>(),
//       homeCubit: getIt<HomeCubit>(),
//     ),
//   );

//   // Register Bloc
//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(
//       registerUseCase: getIt<RegisterUseCase>(),
//     ),
//   );
// }

// void _initHomeDependencies() {
//   getIt.registerFactory<HomeCubit>(() => HomeCubit());
// }
import 'package:clean_ease/app/shared_prefs/token_shared_prefs.dart';
import 'package:clean_ease/core/network/api_service.dart';
import 'package:clean_ease/core/network/hive_service.dart';
import 'package:clean_ease/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:clean_ease/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:clean_ease/features/auth/data/repository/auth_local_repository.dart';
import 'package:clean_ease/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:clean_ease/features/auth/domain/use_case/login_usecase.dart';
import 'package:clean_ease/features/auth/domain/use_case/register_usecase.dart';
import 'package:clean_ease/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:clean_ease/features/auth/domain/use_case/verify_usecase.dart';
import 'package:clean_ease/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initApiService();
  await _initSharedPreferences();
  await _initLoginDependencies();
  await _initSignupDependencies();
  _initHomeDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void _initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

// **FIXED: Added missing VerifyEmailUsecase registration**
Future<void> _initSignupDependencies() async {
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(getIt<AuthRemoteRepository>()),
  );

  // **FIXED: Register VerifyEmailUsecase before using it**
  getIt.registerLazySingleton<VerifyEmailUsecase>(
    () => VerifyEmailUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      verifyEmailUsecase: getIt<VerifyEmailUsecase>(),
      // uploadImageUsecase:
      // getIt<UploadImageUsecase>(), // Fixed: Added UploadImageUsecase
    ),
  );
}

// **FIXED: Ensure TokenSharedPrefs is injected in LoginUseCase**
Future<void> _initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      // getIt<TokenSharedPrefs>(), // Fixed: Injected TokenSharedPrefs
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}
