import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_ease/common/navigator.dart';
import 'package:clean_ease/view/calendar_view.dart';
import 'package:clean_ease/view/order_view.dart';
import 'package:clean_ease/view/settings_view.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CalendarView()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderView()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsView()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/image1.jpg'),
            ),
            SizedBox(width: screenWidth * 0.02),
            const Column(
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
            onPressed: () {},
          ),
        ],
      ),
      body: _getSelectedScreen(_selectedIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return _buildHomeScreen();
      default:
        return _buildHomeScreen();
    }
  }

  Widget _buildHomeScreen() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Section: Our Services
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: _boxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildServiceCard(
                              context,
                              'Automated Laundry',
                              'assets/images/washingmachine.png',
                              Colors.orange,
                              const Text('Automated Laundry Page')),
                          _buildServiceCard(
                              context,
                              'Dry Cleaning',
                              'assets/images/folded clothes.png',
                              Colors.orange,
                              const Text('Dry Cleaning Page')),
                          _buildServiceCard(
                              context,
                              'Only Press',
                              'assets/images/iron.jpg',
                              Colors.orange,
                              const Text('Only Press Page')),
                          _buildServiceCard(
                              context,
                              'Shoe Cleaning',
                              'assets/images/shoe.jpg',
                              Colors.orange,
                              const Text('Shoe Cleaning Page')),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Second Section: Price List
            Container(
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.03,
                horizontal: screenWidth * 0.04,
              ),
              decoration: _boxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Third Section: Our Offers
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: _boxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Offers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPromotionalBanner(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionalBanner() {
    final DateTime offerEndDate = DateTime.now().add(const Duration(days: 5));

    return CarouselSlider(
      options: CarouselOptions(
        height: 150.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        {
          'title': '20% Off on Dry Cleaning!',
          'description':
              'Hurry up! Offer ends in ${_getRemainingDays(offerEndDate)} days!',
          'color': Colors.lightBlue,
          'image': 'assets/images/folded clothes.png',
        },
        {
          'title': 'Flat 15% Off on Shoe Cleaning!',
          'description': 'Limited time offer. Don\'t miss out!',
          'color': const Color.fromARGB(255, 85, 163, 226),
          'image': 'assets/images/best.png',
        },
      ].map((offer) {
        final String title = offer['title'] as String;
        final String description = offer['description'] as String;
        final Color color = offer['color'] as Color;
        final String image = offer['image'] as String;

        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  int _getRemainingDays(DateTime endDate) {
    final DateTime now = DateTime.now();
    return endDate.difference(now).inDays;
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
          boxShadow: const [
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
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(2, 2),
        ),
      ],
    );
  }
}
