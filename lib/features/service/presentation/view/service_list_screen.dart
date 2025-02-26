import 'package:clean_ease/features/booking/presentation/view/booking_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/service_entity.dart';
import '../view_model/service_block.dart';
import '../view_model/service_event.dart';
import '../view_model/service_state.dart';

class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceBloc = BlocProvider.of<ServiceBloc>(context);

    // ✅ Prevent adding events to a closed Bloc
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!serviceBloc.isClosed) {
        serviceBloc.add(GetServicesEvent());
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Available Services")),
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
            return ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                final ServiceEntity service = state.services[index];
                return ServiceCard(service: service);
              },
            );
          }
          return const Center(child: Text('Fetching services...'));
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
        ? 'http://10.0.2.2:3000${service.image}'
        : 'https://via.placeholder.com/150';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.network(imageUrl,
                  width: 50, height: 50, fit: BoxFit.cover),
              title: Text(service.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service.description),
                  Text("Category: ${service.category}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("Price: \$${service.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // ✅ Added "Book Now" button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingView(
                        serviceTitle: service.title,
                        servicePrice: service.price,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Teal-colored button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text("Book Now",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
