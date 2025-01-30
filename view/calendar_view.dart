import 'package:clean_ease/core/common/navigator.dart';
import 'package:flutter/material.dart';

import 'home_page_view.dart';
import 'order_view.dart';
import 'settings_view.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Calendar Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1, // Index for the Calendar page
        onTap: (int index) {
          // Handle navigation based on the index
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreenView(),
                ),
              );
              break;
            case 1:
              // Already on the Calendar page
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderView(),
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
