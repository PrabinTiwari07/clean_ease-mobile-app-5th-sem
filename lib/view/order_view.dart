import 'package:clean_ease/common/navigator.dart';
import 'package:clean_ease/view/calendar_view.dart';
import 'package:clean_ease/view/home_page_view.dart';
import 'package:clean_ease/view/settings_view.dart';
import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Order Content Goes Here',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Index for the Order page
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarView(),
                ),
              );
              break;
            case 2:
              // Already on the Order page
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
