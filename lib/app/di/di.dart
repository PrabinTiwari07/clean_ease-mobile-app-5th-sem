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
import 'package:clean_ease/features/booking/data/repository/booking_repository.dart';
import 'package:clean_ease/features/booking/domain/repository/booking_repository.dart';
import 'package:clean_ease/features/booking/domain/use_case/booking_use_case.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
import 'package:clean_ease/features/price/data/data_source/price_remote_data_source.dart';
import 'package:clean_ease/features/price/data/repository/price_repository.dart';
import 'package:clean_ease/features/price/domain/use_case/get_price_use_case.dart';
import 'package:clean_ease/features/price/presentation/view_model/price_bloc.dart';
import 'package:clean_ease/features/profile/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:clean_ease/features/profile/data/repository/profile_repository.dart';
import 'package:clean_ease/features/profile/domain/repository/profile_repository.dart';
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:clean_ease/features/service/data/data_source/remote_data_source/service_remote_data_source.dart';
import 'package:clean_ease/features/service/data/repository/service_remote_repository.dart';
import 'package:clean_ease/features/service/domain/use_case/get_service_by_id_usecase.dart';
import 'package:clean_ease/features/service/domain/use_case/service_use_case.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  _initApiService();
  await _initSharedPreferences();
  await _initLoginDependencies();
  await _initSignupDependencies();
  _initHomeDependencies();
  _initServiceDependencies();
  await _initProfileDependencies();
  initPriceDependencies();
  await _initBookingDependencies();
}

Future<void> _initHiveService() async {
  await Hive.initFlutter();
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

///  Register Shared Preferences
Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

///  Register API Service (Dio)
void _initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

///  Register HomeCubit
void _initHomeDependencies() {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

void _initServiceDependencies() {
  //  Register ServiceRemoteDataSource
  getIt.registerLazySingleton<ServiceRemoteDataSource>(
    () => ServiceRemoteDataSource(dio: getIt<Dio>()),
  );

  //  Register Service Repository
  getIt.registerLazySingleton<ServiceRemoteRepository>(
    () => ServiceRemoteRepository(
        serviceRemoteDataSource: getIt<ServiceRemoteDataSource>()),
  );

  //  Register Use Cases
  getIt.registerLazySingleton<GetServicesUseCase>(
    () =>
        GetServicesUseCase(serviceRepository: getIt<ServiceRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetServiceByIdUseCase>(
    () => GetServiceByIdUseCase(
        serviceRepository: getIt<ServiceRemoteRepository>()),
  );

  //  Register ServiceBloc
  getIt.registerFactory<ServiceBloc>(
    () => ServiceBloc(
      getServicesUseCase: getIt<GetServicesUseCase>(),
      // getServiceByIdUseCase: getIt<GetServiceByIdUseCase>(),
    ),
  );
}

// Register Profile Dependencies
Future<void> _initProfileDependencies() async {
  // Register Profile Remote Data Source
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(
      dio: getIt<Dio>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Inject token storage
    ),
  );

// Register Profile Repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
        remoteDataSource: getIt<ProfileRemoteDataSource>()),
  );

// Register GetProfileUseCase
  getIt.registerLazySingleton<GetProfileUseCase>(
    () => GetProfileUseCase(getIt<ProfileRepository>()),
  );

// Register ProfileBloc
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(getProfileUseCase: getIt<GetProfileUseCase>()),
  );
}

// Register Signup Dependencies
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

  getIt.registerLazySingleton<VerifyEmailUsecase>(
    () => VerifyEmailUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      verifyEmailUsecase: getIt<VerifyEmailUsecase>(),
    ),
  );
}

// Register Login Dependencies
Future<void> _initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

void initPriceDependencies() {
  getIt.registerLazySingleton<PriceRemoteDataSource>(
    () => PriceRemoteDataSource(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<PriceRepository>(
    () => PriceRepository(remoteDataSource: getIt<PriceRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetPricesUseCase>(
    () => GetPricesUseCase(priceRepository: getIt<PriceRepository>()),
  );

  getIt.registerFactory<PriceBloc>(
    () => PriceBloc(serviceBloc: getIt<ServiceBloc>()), //  Use ServiceBloc
  );
}

Future<void> _initBookingDependencies() async {
  //  Register TokenSharedPrefs
  // getIt.registerLazySingleton<TokenSharedPrefs>(
  //   () => TokenSharedPrefs(getIt<SharedPreferences>()),
  // );

  //  Register Booking Repository
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(
      dio: getIt<Dio>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );

  //  Register Booking Use Case
  getIt.registerLazySingleton<BookingUseCase>(
    () => BookingUseCase(
      bookingRepository: getIt<BookingRepository>(),
    ),
  );
  //  Register BookingHistoryBloc
// getIt.registerFactory<BookingBloc>(
//   () => BookingHistoryBloc(bookingRepository: getIt<BookingRepository>()),
// );

  if (!getIt.isRegistered<BookingBloc>()) {
    getIt.registerFactory<BookingBloc>(
      () => BookingBloc(
        bookingUseCase: getIt<BookingUseCase>(),
      ),
    );
  }
}
