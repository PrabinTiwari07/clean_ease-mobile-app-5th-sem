import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/order.dart';
import 'package:clean_ease/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

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
                  builder: (context) => const Home(),
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
                  builder: (context) => const Order(),
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileView(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
