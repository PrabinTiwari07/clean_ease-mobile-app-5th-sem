// // import 'package:flutter/material.dart';

// // import '../../domain/entity/service_entity.dart';

// // class RoomDetailScreen extends StatelessWidget {
// //   final ServiceEntity room;

// //   const RoomDetailScreen({super.key, required this.room});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text(room.name)),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             if (room.images.isNotEmpty)
// //               SizedBox(
// //                 height: 200,
// //                 child: ListView.builder(
// //                   scrollDirection: Axis.horizontal,
// //                   itemCount: room.images.length,
// //                   itemBuilder: (context, index) {
// //                     final String imageUrl =
// //                         'http://10.0.2.2:3000/${room.images[index].replaceAll("public/", "").replaceAll("\\", "/")}';

// //                     return Padding(
// //                       padding: const EdgeInsets.all(8),
// //                       child: Image.network(
// //                         imageUrl,
// //                         width: 300,
// //                         fit: BoxFit.cover,
// //                         errorBuilder: (context, error, stackTrace) {
// //                           return const Icon(Icons.error,
// //                               size: 100, color: Colors.red);
// //                         },
// //                       ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             const SizedBox(height: 16),
// //             Text(
// //               room.name,
// //               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 8),
// //             Text('Type: ${room.type}'),
// //             const SizedBox(height: 8),
// //             Text('Price: NRs. ${room.price.toStringAsFixed(0)}'),
// //             const SizedBox(height: 16),
// //             const Text('Description:', style: TextStyle(fontSize: 18)),
// //             const SizedBox(height: 8),
// //             Text(room.description),
// //             const SizedBox(height: 16),
// //             const Text('Amenities:', style: TextStyle(fontSize: 18)),
// //             const SizedBox(height: 8),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// import '../../domain/entity/service_entity.dart';

// class ServicesScreen extends StatelessWidget {
//   final List<ServiceEntity> services;

//   const ServicesScreen({super.key, required this.services});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Available Services")),
//       body: ListView.builder(
//         itemCount: services.length,
//         itemBuilder: (context, index) {
//           final service = services[index];
//           return Card(
//             margin: const EdgeInsets.all(8),
//             child: ListTile(
//               leading: service.image.isNotEmpty
//                   ? Image.network('http://localhost:3000${service.image}',
//                       width: 50, height: 50, fit: BoxFit.cover)
//                   : const Icon(Icons.cleaning_services, size: 50),
//               title: Text(service.title,
//                   style: const TextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(service.description),
//                   Text("Category: ${service.category}",
//                       style: const TextStyle(fontSize: 12, color: Colors.grey)),
//                   Text("Price: \$${service.price.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                           fontSize: 14, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
