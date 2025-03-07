import 'dart:ui'; // For BackdropFilter

import 'package:clean_ease/features/service/domain/entity/service_entity.dart';
import 'package:clean_ease/features/service/presentation/view/service_list_screen.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_bloc.dart';
import 'package:clean_ease/features/service/presentation/view_model/service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceListScreen extends StatelessWidget {
  const PriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // For transparent app bar effect
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.teal.withOpacity(0.8),
      elevation: 0,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.teal.withOpacity(0.3)),
        ),
      ),
      title: const Text(
        "Price List",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      foregroundColor: Colors.white,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, serviceState) {
            if (serviceState is ServiceLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              );
            } else if (serviceState is ServicesLoaded) {
              final services = serviceState.services;
              if (services.isEmpty) {
                return const Center(
                  child: Text(
                    "No services available",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                );
              }
              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _buildServiceCard(context, service);
                },
              );
            } else {
              return const Center(
                child: Text(
                  "Error loading services",
                  style: TextStyle(fontSize: 18, color: Colors.redAccent),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceEntity service) {
    // final String imageUrl = service.image.isNotEmpty
    //     ? 'http://10.0.2.2:3000${service.image}'
    //     : 'https://via.placeholder.com/150';

    final String imageUrl = service.image.isNotEmpty
        ? 'http://192.168.1.71:3000${service.image}'
        : 'https://via.placeholder.com/150';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ServiceListScreen()),
        );
      },
      child: GlassContainer(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Title and Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade900,
                          fontSize: 18,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "\$${service.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Trailing Icon
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.teal.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Glassmorphism Container
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: padding ?? const EdgeInsets.all(16.0),
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: child,
        ),
      ),
    );
  }
}
