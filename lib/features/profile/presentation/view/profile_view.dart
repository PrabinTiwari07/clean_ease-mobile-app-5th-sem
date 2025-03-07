import 'dart:async';

import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/auth/presentation/view/login.dart';
import 'package:clean_ease/features/booking/presentation/view/booking_history_view.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/home/presentation/view/home_view/home.dart';
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:clean_ease/features/profile/presentation/view/about_us_view.dart';
import 'package:clean_ease/features/profile/presentation/view/edit_profile_view.dart';
import 'package:clean_ease/features/profile/presentation/view/permission_view.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_event.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_state.dart';
import 'package:clean_ease/features/service/presentation/view/service_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart'; //  Import sensors_plus

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  StreamSubscription? _accelerometerSubscription;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _listenToShake();
    _loadThemePreference();
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
        //  Shake threshold
        _performLogout(context);
      }
    });
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false,
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ProfileBloc(
            getProfileUseCase: getIt<GetProfileUseCase>(),
          )..add(LoadProfile()),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                return Column(
                  children: [
                    //  Profile Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: state.profile.image.isNotEmpty
                                  ? NetworkImage(
                                      _formatImageUrl(state.profile.image))
                                  : const AssetImage('assets/images/goats.jpg')
                                      as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.profile.fullname,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            state.profile.phone,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            state.profile.email,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),

                    //  Profile Options
                    Expanded(
                      child: ListView(
                        children: [
                          ProfileOption(
                            icon: Icons.edit,
                            text: "Edit Profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditProfileView(),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                              color: Colors.teal,
                            ),
                            title: const Text("Dark Mode",
                                style: TextStyle(fontSize: 16)),
                            trailing: Switch(
                              value: _isDarkMode,
                              onChanged: (value) {
                                _toggleDarkMode(value);
                              },
                            ),
                          ),
                          ProfileOption(
                            icon: Icons.info,
                            text: "About Us",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutUsView()),
                              );
                            },
                          ),
                          ProfileOption(
                            icon: Icons.article,
                            text: "Terms and Conditions",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PermissionView()),
                              );
                            },
                          ),
                          ProfileOption(
                            icon: Icons.logout,
                            text: "Logout",
                            onTap: () {
                              _showLogoutDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("Failed to load profile"));
              }
            },
          ),
        ),
      ),
      //  Bottom Navigation Bar with Profile highlighted
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          if (index != 3) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                if (index == 0) return const Home();
                if (index == 1) return const Calendar();
                if (index == 2) return const ServiceListScreen();
                if (index == 4) return const BookingHistoryView();
                return const ProfileView();
              }),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}

// Function to Correct Image URL
String _formatImageUrl(String imageUrl) {
  if (imageUrl.startsWith('http')) {
    return imageUrl.replaceFirst(
        'http://localhost:3000', 'http://192.168.1.71:3000');
  }
  return 'http://192.168.1.71:3000$imageUrl';
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _performLogout(context);
            },
            child: const Text("Yes, Logout"),
          ),
        ],
      );
    },
  );
}

void _performLogout(BuildContext context) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: "Logged out successfully",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
  );

  Future.delayed(const Duration(milliseconds: 800), () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  });
}

//  Define ProfileOption widget
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}
