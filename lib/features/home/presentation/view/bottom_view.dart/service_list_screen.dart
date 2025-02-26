// import 'package:clean_ease/core/common/navigator.dart';
// import 'package:clean_ease/features/home/presentation/home.dart';
// import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
// import 'package:clean_ease/features/profile/presentation/view/profile_view.dart';
// import 'package:flutter/material.dart';

// class Order extends StatelessWidget {
//   const Order({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order View'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'Order Screen',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//         currentIndex: 2,
//         onTap: (int index) {
//           switch (index) {
//             case 0:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Home(),
//                 ),
//               );
//               break;
//             case 1:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Calendar(),
//                 ),
//               );
//               break;
//             case 2:
//               break;
//             case 3:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ProfileView(),
//                 ),
//               );
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
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
    const ServiceListScreen(), // ✅ Navigate to service list when tapping the 3rd icon
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Services'), // ✅ Corrected label
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
