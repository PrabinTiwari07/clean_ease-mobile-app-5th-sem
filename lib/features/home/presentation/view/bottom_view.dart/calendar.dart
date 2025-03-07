import 'dart:async';

import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/booking/presentation/view/booking_history_view.dart';
import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/profile_view.dart';
import 'package:clean_ease/features/service/presentation/view/service_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensors_plus/sensors_plus.dart';
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

    final today = DateTime.now();
    _events = {
      DateTime(today.year, today.month, today.day + 2): [
        'Flat 20% Discount on shoe cleaning',
        'Get 15% discount on dry cleaning'
      ],
      DateTime(today.year, today.month, today.day + 5): [
        '5% discount on all services'
      ],
      DateTime(today.year, today.month, today.day + 10): [
        '10% discount on ironing'
      ],
    };

    _listenToShake();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _listenToShake() {
    bool hasRefreshed = false;

    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double acceleration = event.x.abs() + event.y.abs() + event.z.abs();

      if (acceleration > 15 && !hasRefreshed) {
        hasRefreshed = true;

        Future.delayed(const Duration(seconds: 1), () {
          setState(() {});

          Fluttertoast.showToast(
            msg: "Your screen has refreshed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
          );

          Future.delayed(const Duration(seconds: 2), () {
            hasRefreshed = false;
          });
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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth > 600;

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
            body: isTablet
                ? Row(
                    children: [
                      Expanded(flex: 3, child: _buildCalendar(isTablet)),
                      Expanded(flex: 2, child: _buildEventList()),
                    ],
                  )
                : Column(
                    children: [
                      _buildCalendar(isTablet),
                      Expanded(child: _buildEventList()),
                    ],
                  ),
            bottomNavigationBar: isTablet
                ? null
                : CustomBottomNavigationBar(
                    currentIndex: 1,
                    onTap: (index) {
                      if (index != 1) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) {
                            if (index == 0) return const Home();
                            if (index == 2) return const ServiceListScreen();
                            if (index == 3) return const ProfileView();
                            if (index == 4) return const BookingHistoryView();
                            return const Calendar();
                          }),
                          (route) => false,
                        );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _buildCalendar(bool isTablet) {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      availableCalendarFormats: {
        CalendarFormat.month: 'Month',
        if (isTablet) CalendarFormat.week: 'Week',
      },
      eventLoader: _getEventsForDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
        selectedDecoration:
            BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
        outsideDaysVisible: false,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: true,
        titleCentered: true,
        formatButtonShowsNext: false,
      ),
    );
  }
}
