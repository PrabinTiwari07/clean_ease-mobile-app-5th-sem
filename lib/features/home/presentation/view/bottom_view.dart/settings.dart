import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/order.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Settings Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Calendar()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Order()),
              );
              break;
            case 3:
              break;
          }
        },
      ),
    );
  }
}
