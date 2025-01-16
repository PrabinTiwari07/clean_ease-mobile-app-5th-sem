import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00CED1), Color(0xFF008080)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        currentIndex: currentIndex,
        onTap: onTap,
        items: List.generate(4, (index) {
          final isSelected = currentIndex == index;
          return BottomNavigationBarItem(
            icon: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(isSelected ? 8.0 : 4.0),
              decoration: BoxDecoration(
                color: isSelected ? Colors.redAccent : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(index),
                size: isSelected ? 28.0 : 24.0,
                color: Colors.white,
              ),
            ),
            label: _getLabel(index),
          );
        }),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.calendar_today;
      case 2:
        return Icons.shopping_bag;
      case 3:
        return Icons.settings;
      default:
        return Icons.home;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 1:
        return 'Calendar';
      case 2:
        return 'Order';
      case 3:
        return 'Settings';
      default:
        return 'Home';
    }
  }
}
