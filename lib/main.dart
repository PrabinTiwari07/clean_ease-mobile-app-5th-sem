import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/features/auth/data/model/auth_hive_model.dart';
import 'package:clean_ease/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
import 'package:clean_ease/features/splash/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies (including Hive)
  await initDependencies();
  await Hive.initFlutter(); // Initialize Hive with Flutter support
  Hive.registerAdapter(UserHiveModelAdapter());

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
      ],
      child: MaterialApp(
        title: 'clean_ease',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const SplashScreen(), // Replace with your initial screen
      ),
    );
  }
}
