import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/settings.dart';
import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Order Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Calendar(),
                ),
              );
              break;
            case 2:
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
