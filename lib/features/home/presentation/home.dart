import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/booking/presentation/view/booking_history_view.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/price/presentation/view/price_list_screen.dart';
import 'package:clean_ease/features/profile/presentation/view/profile_view.dart';
import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:clean_ease/features/service/presentation/view/service_list_screen.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_bloc.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_event.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // ✅ Fetch services when homepage is initialized
    context.read<ServiceBloc>().add(GetServicesEvent());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Calendar()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ServiceListScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileView()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingHistoryView()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/image1.jpg'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Prabin Tiwari',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Jorpati',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ "Our Services" section with fetched services
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: _boxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Services',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<ServiceBloc, ServiceState>(
                    builder: (context, state) {
                      if (state is ServiceLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ServiceError) {
                        return Center(child: Text("Error: ${state.message}"));
                      } else if (state is ServicesLoaded) {
                        if (state.services.isEmpty) {
                          return const Center(
                              child: Text("No services available"));
                        }
                        return _buildServiceGrid(state.services);
                      }
                      return const Center(child: Text('Fetching services...'));
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Second Section: Price List
            Container(
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.03,
                horizontal: screenWidth * 0.04,
              ),
              decoration: _boxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price List',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PriceListScreen()),
                      );
                    },
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Offers',
                    style: Theme.of(context).textTheme.displayMedium,
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
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        {
          'title': '20% Off on Dry Cleaning!',
          'description':
              'Hurry up! Offer ends in ${_getRemainingDays(offerEndDate)} days!',
          'color': Colors.lightBlue.shade400,
          'image': 'assets/images/folded clothes.png',
        },
        {
          'title': 'Flat 15% Off on Shoe Cleaning!',
          'description': 'Limited time offer. Don\'t miss out!',
          'color': Colors.blue.shade300,
          'image': 'assets/images/shoe.jpg',
        },
      ].map((offer) {
        return _buildOfferCard(offer);
      }).toList(),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [offer['color'] as Color, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              offer['image'] as String,
              fit: BoxFit.contain,
              height: 100,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer['title'] as String,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  offer['description'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getRemainingDays(DateTime endDate) {
    final DateTime now = DateTime.now();
    return endDate.difference(now).inDays;
  }

  /// ✅ Creates a service card with compact design for vertical scrolling
  Widget _buildServiceCard(BuildContext context, ServiceEntity service) {
    final String imageUrl = service.image.isNotEmpty
        ? 'http://10.0.2.2:3000${service.image}'
        : 'https://via.placeholder.com/150';

    return Container(
      decoration: _boxDecoration(),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 80, // ✅ Smaller image height
              width: 80, // ✅ Smaller image width
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  service.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
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

/// ✅ Dynamically builds service grid from fetched services
Widget _buildServiceGrid(List<ServiceEntity> services) {
  return LayoutBuilder(
    builder: (context, constraints) {
      int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return _buildServiceCard(context, service);
        },
      );
    },
  );
}

/// ✅ Builds an individual service card with navigation
Widget _buildServiceCard(BuildContext context, ServiceEntity service) {
  final String imageUrl = service.image.isNotEmpty
      ? 'http://10.0.2.2:3000${service.image}'
      : 'https://via.placeholder.com/150';

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ServiceListScreen()),
      );
    },
    child: Container(
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              service.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPromotionalBanner() {
  return const Text("🚀 Promotional Offers Go Here!");
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
