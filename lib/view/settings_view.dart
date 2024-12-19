import 'package:clean_ease/common/navigator.dart';
import 'package:clean_ease/view/calendar_view.dart';
import 'package:clean_ease/view/home_page_view.dart';
import 'package:clean_ease/view/order_view.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page"),
      ),
      body: const Center(
        child: Text(
          'Settings Content Goes Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // Index for Settings page
        onTap: (int index) {
          // Handle navigation based on index
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
              // Do nothing, we're already on the Settings page
              break;
          }
        },
      ),
    );
  }
}
