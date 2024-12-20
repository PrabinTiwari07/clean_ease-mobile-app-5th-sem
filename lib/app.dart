import 'package:clean_ease/core/app_theme/app_theme.dart';
import 'package:clean_ease/view/splash_screen_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        '/': (context) => const SplashScreenView(),
      },
    );
  }
}
