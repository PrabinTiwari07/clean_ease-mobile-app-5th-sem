import 'package:clean_ease/core/common/navigator.dart';
import 'package:flutter/material.dart';

import 'calendar_view.dart';
import 'home_page_view.dart';
import 'order_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
                MaterialPageRoute(builder: (context) => const HomeScreenView()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CalendarView()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const OrderView()),
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
