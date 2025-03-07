import 'package:clean_ease/features/booking/presentation/view/booking_history_view.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/profile/presentation/view/profile_view.dart';
import 'package:clean_ease/features/service/presentation/view/service_list_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Calendar(),
    const ServiceListScreen(),
    const BookingHistoryView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type:
            BottomNavigationBarType.fixed, // ✅ Ensures visibility of all icons
        selectedItemColor: Colors.teal, // ✅ Highlights the selected tab
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Services'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'My Booking'), // ✅ New tab for booking history
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
