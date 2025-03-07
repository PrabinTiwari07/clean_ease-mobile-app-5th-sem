import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/booking/presentation/view/booking_history_view.dart';
import 'package:clean_ease/features/booking/presentation/view/booking_view.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/home/presentation/view/home_view/home.dart';
import 'package:clean_ease/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/service_entity.dart';
import '../view_model/service_bloc.dart';
import '../view_model/service_event.dart';
import '../view_model/service_state.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceBloc = BlocProvider.of<ServiceBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!serviceBloc.isClosed) {
        serviceBloc.add(GetServicesEvent());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Services"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: BlocBuilder<ServiceBloc, ServiceState>(
        builder: (context, state) {
          if (state is ServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ServiceError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is ServicesLoaded) {
            if (state.services.isEmpty) {
              return const Center(child: Text("No services available"));
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = (constraints.maxWidth ~/ 280)
                    .clamp(1, 3); // Adjusted to better fit screen
                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 2.0, // Balanced aspect ratio
                  ),
                  itemCount: state.services.length,
                  itemBuilder: (context, index) {
                    final ServiceEntity service = state.services[index];
                    return ServiceCard(service: service);
                  },
                );
              },
            );
          }
          return const Center(child: Text('Fetching services...'));
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index != 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                if (index == 0) return const Home();
                if (index == 1) return const Calendar();
                if (index == 3) return const ProfileView();
                if (index == 4) return const BookingHistoryView();
                return const ServiceListScreen();
              }),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final ServiceEntity service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = service.image.isNotEmpty
        ? 'http://192.168.1.71:3000${service.image}'
        : 'https://via.placeholder.com/150';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(imageUrl,
                      width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(service.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                      Text("Category: ${service.category}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                      Text("Price: \$${service.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingView(service: service),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Book Now",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
