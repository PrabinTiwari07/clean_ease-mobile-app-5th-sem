import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/features/auth/data/model/auth_hive_model.dart';
import 'package:clean_ease/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:clean_ease/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:clean_ease/features/booking/presentation/view_model/booking_bloc.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/bookinghistory.dart';
import 'package:clean_ease/features/home/presentation/view_model/home_cubit.dart';
import 'package:clean_ease/features/price/presentation/view_model/price_bloc.dart';
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_event.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_bloc.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_event.dart';
import 'package:clean_ease/features/splash/presentation/view/splash_screen.dart';
import 'package:flutter/foundation.dart'; // ✅ Detect platform
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ✅ Global Key for accessing Dark Mode state
final GlobalKey<_MyAppStatefulState> myAppKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies(); // Initialize GetIt DI
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveModelAdapter());

  runApp(MyAppStateful(key: myAppKey)); // ✅ Use Stateful App Wrapper
}

class MyAppStateful extends StatefulWidget {
  const MyAppStateful({super.key});

  @override
  State<MyAppStateful> createState() => _MyAppStatefulState();
}

class _MyAppStatefulState extends State<MyAppStateful> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference(); // ✅ Load Theme Preference
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void toggleDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  bool get isDarkMode => _isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerHover:
          !kIsWeb ? (_) {} : null, // ✅ Disables mouse hover tracking on mobile
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {}, // ✅ Forces touch gestures only
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(create: (_) => getIt<LoginBloc>()),
            BlocProvider<RegisterBloc>(create: (_) => getIt<RegisterBloc>()),
            BlocProvider<HomeCubit>(create: (_) => getIt<HomeCubit>()),
            BlocProvider<ProfileBloc>(
              create: (_) =>
                  ProfileBloc(getProfileUseCase: getIt<GetProfileUseCase>())
                    ..add(LoadProfile()),
            ),
            BlocProvider<ServiceBloc>(
              create: (_) => getIt<ServiceBloc>()..add(GetServicesEvent()),
            ),
            BlocProvider<PriceBloc>(
              create: (context) =>
                  PriceBloc(serviceBloc: context.read<ServiceBloc>()),
            ),
            BlocProvider<BookingBloc>(create: (_) => getIt<BookingBloc>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CleanEase',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
            routes: {
              '/home': (context) => const BottomNavigation(),
            },
          ),
        ),
      ),
    );
  }
}
