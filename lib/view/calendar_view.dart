import 'package:clean_ease/common/navigator.dart';
import 'package:clean_ease/view/home_page_view.dart';
import 'package:clean_ease/view/order_view.dart';
import 'package:clean_ease/view/settings_view.dart';
import 'package:flutter/material.dart';

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
          'Calendar Content Goes Here',
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
