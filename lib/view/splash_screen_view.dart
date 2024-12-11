import 'package:clean_ease/view/admin_login_view.dart';
import 'package:clean_ease/view/login_view.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to CleanEase"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.red,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const Text("Siuuu"),
              Image.asset("assets/images/cleanEase.png"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()));
                },
                child: const Text("User"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminLoginView()));
                },
                child: const Text("Admin"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
