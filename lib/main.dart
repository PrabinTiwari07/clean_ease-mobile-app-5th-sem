// import 'package:clean_ease/app/di/di.dart';
// import 'package:clean_ease/features/auth/data/model/auth_hive_model.dart';
// import 'package:clean_ease/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
// import 'package:clean_ease/features/splash/presentation/view/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/adapters.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await initDependencies();
//   await Hive.initFlutter();
//   Hive.registerAdapter(UserHiveModelAdapter());
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<LoginBloc>(
//           create: (_) => getIt<LoginBloc>(),
//         ),
//         BlocProvider<RegisterBloc>(
//           create: (_) => getIt<RegisterBloc>(),
//         ),
//         BlocProvider<HomeCubit>(
//           create: (_) => getIt<HomeCubit>(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'clean_ease',
//         theme: ThemeData(
//           primarySwatch: Colors.teal,
//         ),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }

import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/features/auth/data/model/auth_hive_model.dart';
import 'package:clean_ease/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
import 'package:clean_ease/features/price/presentation/view_model/price_bloc.dart';
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_block.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_event.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_block.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_event.dart';
import 'package:clean_ease/features/splash/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies(); // Initialize GetIt DI

  await Hive.initFlutter();

  Hive.registerAdapter(UserHiveModelAdapter());
  // ✅ Register Hive Adapter
  // Hive.registerAdapter(ProfileHiveModelAdapter());

  // ✅ Open Hive Box Before DI Setup
  // await Hive.openBox<ProfileHiveModel>('profile_box');
  // await Hive.openBox('user_box');

  // ✅ Ensure all Hive Boxes are fully opened before moving forward
  // await Future.wait([
  //   Hive.openBox('user_box'),
  //   Hive.openBox<ProfileHiveModel>('profile_box'),
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => getIt<RegisterBloc>(),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => getIt<HomeCubit>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
            getProfileUseCase: getIt<GetProfileUseCase>(),
          )..add(LoadProfile()),
        ),
        BlocProvider<ServiceBloc>(
          create: (_) => getIt<ServiceBloc>()..add(GetServicesEvent()),
        ),
        BlocProvider<PriceBloc>(
          create: (context) =>
              PriceBloc(serviceBloc: context.read<ServiceBloc>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'clean_ease',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
