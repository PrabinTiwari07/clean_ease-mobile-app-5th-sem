import 'package:clean_ease/view/automated_laundry_page_view.dart';
import 'package:clean_ease/view/dry_cleaning_page_view.dart';
import 'package:clean_ease/view/notification_view.dart';
import 'package:clean_ease/view/only_press_page_view.dart';
import 'package:clean_ease/view/shoe_cleaning_page_view.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20, // Adjust the size of the profile icon
              backgroundImage: AssetImage('assets/images/image1.jpg'),
            ),
            SizedBox(width: 10), // Add spacing between the image and the text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Prabin Tiwari',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Dillibazar, Kathmandu',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationView()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildServiceCard(
                      context,
                      'Automated Laundry',
                      'assets/images/washingmachine.png',
                      Colors.lightBlue,
                      const AutomatedLaundryViewPage()),
                  _buildServiceCard(
                      context,
                      'Dry Cleaning',
                      'assets/images/folded clothes.png',
                      Colors.pinkAccent,
                      const DryCleaningPageView()),
                  _buildServiceCard(
                      context,
                      'Only Press',
                      'assets/images/iron.jpg',
                      Colors.green,
                      const OnlyPressPageView()),
                  _buildServiceCard(
                      context,
                      'Shoe Cleaning',
                      'assets/images/shoe.jpg',
                      Colors.orange,
                      const ShoeCleaningPageView()),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Price List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String assetPath,
      Color color, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => targetPage));
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                assetPath,
                height: 120, // Increased size
                width: 140, // Make it proportional
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreenView(),
    ));
