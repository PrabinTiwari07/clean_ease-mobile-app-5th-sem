import 'package:clean_ease/core/theme/app_theme.dart';
import 'package:clean_ease/features/auth/presentation/view/login.dart';
import 'package:clean_ease/features/auth/presentation/view/register.dart';
import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:clean_ease/features/splash/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => Login(),
          "/register": (context) => const Register(),
          "/dashboard": (context) => const Home(),
        });
  }
}
