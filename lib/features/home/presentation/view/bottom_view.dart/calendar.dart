// import 'package:clean_ease/core/common/navigator.dart';
// import 'package:clean_ease/features/booking/presentation/view/booking_history_view.dart';
// import 'package:clean_ease/features/home/presentation/home.dart';
// import 'package:clean_ease/features/profile/presentation/view/profile_view.dart';
// import 'package:clean_ease/features/service/presentation/view/service_list_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class Calendar extends StatefulWidget {
//   const Calendar({super.key});

//   @override
//   State<Calendar> createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   Map<DateTime, List<dynamic>> _events = {};

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;

//     // Example events - you can replace this with your actual events data
//     final today = DateTime.now();
//     _events = {
//       DateTime(today.year, today.month, today.day + 2): [
//         'Cleaning Service',
//         'Home Cleaning'
//       ],
//       DateTime(today.year, today.month, today.day + 5): ['Office Cleaning'],
//       DateTime(today.year, today.month, today.day + 10): [
//         'Deep Cleaning Service'
//       ],
//     };
//   }

//   List<dynamic> _getEventsForDay(DateTime day) {
//     // Normalize date to avoid time comparison issues
//     final normalizedDay = DateTime(day.year, day.month, day.day);

//     return _events[normalizedDay] ?? [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigate to Home page when back button is pressed
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const Home(),
//           ),
//         );
//         return false; // Prevent default back button behavior
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Calendar View'),
//           centerTitle: true,
//           backgroundColor: Colors.teal,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               // Navigate to Home page when back button is pressed
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const Home(),
//                 ),
//               );
//             },
//           ),
//         ),
//         body: Column(
//           children: [
//             TableCalendar(
//               firstDay: DateTime.utc(2023, 1, 1),
//               lastDay: DateTime.utc(2025, 12, 31),
//               focusedDay: _focusedDay,
//               calendarFormat: _calendarFormat,
//               eventLoader: _getEventsForDay,
//               selectedDayPredicate: (day) {
//                 return isSameDay(_selectedDay, day);
//               },
//               onDaySelected: (selectedDay, focusedDay) {
//                 if (!isSameDay(_selectedDay, selectedDay)) {
//                   setState(() {
//                     _selectedDay = selectedDay;
//                     _focusedDay = focusedDay;
//                   });
//                 }
//               },
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 _focusedDay = focusedDay;
//               },
//               calendarStyle: CalendarStyle(
//                 todayDecoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor.withOpacity(0.5),
//                   shape: BoxShape.circle,
//                 ),
//                 selectedDecoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   shape: BoxShape.circle,
//                 ),
//                 markerDecoration: const BoxDecoration(
//                   color: Colors.green,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//               headerStyle: const HeaderStyle(
//                 formatButtonVisible: true,
//                 titleCentered: true,
//                 formatButtonShowsNext: false,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: _selectedDay == null
//                   ? const Center(
//                       child: Text(
//                         'Select a day to view events',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     )
//                   : _buildEventList(),
//             ),
//           ],
//         ),
//         bottomNavigationBar: CustomBottomNavigationBar(
//           currentIndex: 1, // Index for the Calendar page
//           onTap: (int index) {
//             // Handle navigation based on the index
//             switch (index) {
//               case 0:
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const Home(),
//                   ),
//                 );
//                 break;
//               case 1:
//                 // Already on the Calendar page
//                 break;
//               case 2:
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const ServiceListScreen(),
//                   ),
//                 );
//                 break;
//               case 3:
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const ProfileView(),
//                   ),
//                 );
//                 break;

//               case 4:
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const BookingHistoryView()),
//                 );
//                 break;
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildEventList() {
//     final events = _getEventsForDay(_selectedDay!);

//     return events.isEmpty
//         ? Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.event_available,
//                   size: 50,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'No events for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
//                   style: const TextStyle(fontSize: 18, color: Colors.grey),
//                 ),
//               ],
//             ),
//           )
//         : ListView.builder(
//             itemCount: events.length,
//             padding: const EdgeInsets.all(16),
//             itemBuilder: (context, index) {
//               return Card(
//                 elevation: 3,
//                 margin: const EdgeInsets.symmetric(vertical: 8),
//                 child: ListTile(
//                   leading:
//                       const Icon(Icons.cleaning_services, color: Colors.blue),
//                   title: Text(
//                     events[index].toString(),
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     'Scheduled for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     // Handle event tap
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Selected event: ${events[index]}'),
//                         duration: const Duration(seconds: 2),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//   }
// }

import 'dart:async';

import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // ✅ Import Fluttertoast
import 'package:sensors_plus/sensors_plus.dart'; // ✅ Import sensors_plus
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<dynamic>> _events = {};
  StreamSubscription? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // Example events - replace with actual event data
    final today = DateTime.now();
    _events = {
      DateTime(today.year, today.month, today.day + 2): [
        'Cleaning Service',
        'Home Cleaning'
      ],
      DateTime(today.year, today.month, today.day + 5): ['Office Cleaning'],
      DateTime(today.year, today.month, today.day + 10): [
        'Deep Cleaning Service'
      ],
    };

    // ✅ Listen for accelerometer shake to refresh the page
    _listenToShake();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _listenToShake() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double acceleration = event.x.abs() + event.y.abs() + event.z.abs();
      if (acceleration > 15) {
        // ✅ Shake threshold
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {}); // Refresh the page after 3 seconds delay
          Fluttertoast.showToast(
            msg: "Your screen has refreshed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
          );
        });
      }
    });
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay!);
    return events.isEmpty
        ? Center(
            child: Text(
              'No events for ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: events.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.event, color: Colors.blue),
                  title: Text(
                    events[index].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calendar View'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),
        ),
        body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _selectedDay == null
                  ? const Center(
                      child: Text(
                        'Select a day to view events',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : _buildEventList(),
            ),
          ],
        ),
      ),
    );
  }
}
