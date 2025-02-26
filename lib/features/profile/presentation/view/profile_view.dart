// import 'package:clean_ease/app/di/di.dart';
// import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
// import 'package:clean_ease/features/profile/presentation/view_model/profile_block.dart';
// import 'package:clean_ease/features/profile/presentation/view_model/profile_event.dart';
// import 'package:clean_ease/features/profile/presentation/view_model/profile_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: BlocProvider(
//         create: (context) => ProfileBloc(
//           getProfileUseCase: getIt<GetProfileUseCase>(), // ✅ Use DI
//         )..add(LoadProfile()), // Fetch user details on load
//         child: BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProfileLoaded) {
//               return Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: state.profile.image.isNotEmpty
//                         ? NetworkImage(
//                             state.profile.image) // ✅ Fetch from network
//                         : const AssetImage('assets/images/default_avatar.png')
//                             as ImageProvider, // ✅ Default image
//                   ),
//                   Text("First Name: ${state.profile.fullname}"),
//                   Text("Address: ${state.profile.address}"),
//                   Text("Phone: ${state.profile.phone}"),
//                   Text("Email: ${state.profile.email}"),
//                 ],
//               );
//             } else if (state is ProfileError) {
//               return Center(child: Text(state.message));
//             } else {
//               return const Center(child: Text('Failed to load user details'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/core/common/navigator.dart';
import 'package:clean_ease/features/home/presentation/home.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/calendar.dart';
import 'package:clean_ease/features/home/presentation/view/bottom_view.dart/service_view.dart';
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_block.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_event.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
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
                    const SizedBox(height: 20),

                    // Back Button & Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context), // Go Back
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Profile Picture with Edit Button
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: state.profile.image.isNotEmpty
                              ? NetworkImage(state.profile.image)
                              : const AssetImage(
                                      'assets/images/default_avatar.png')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Form Fields
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // First Name & Last Name
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: "First Name",
                                  initialValue:
                                      state.profile.fullname.split(" ")[0],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Last Name",
                                  initialValue:
                                      state.profile.fullname.split(" ").length >
                                              1
                                          ? state.profile.fullname.split(" ")[1]
                                          : "",
                                ),
                              ),
                            ],
                          ),

                          // Phone Number
                          Row(
                            children: [
                              const SizedBox(
                                width: 60,
                                child: CustomTextField(
                                  label: "Code",
                                  initialValue: "+977",
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: "Phone no",
                                  initialValue: state.profile.phone,
                                ),
                              ),
                            ],
                          ),

                          // Address
                          CustomTextField(
                            label: "Address",
                            initialValue: state.profile.address,
                          ),

                          // Password Fields
                          const CustomTextField(
                            label: "Password",
                            isPassword: true,
                          ),
                          const CustomTextField(
                            label: "Confirm Password",
                            isPassword: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Save & Cancel Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 12),
                          ),
                          child: const Text("Save"),
                        ),
                        const SizedBox(width: 20),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.orange),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
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

      // ✅ Bottom Navigation Bar (Remains Functional)
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3, // ✅ Ensure this matches the Profile tab's index
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Calendar()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const Order()), // If Order exists
              );
              break;
            case 3: // ✅ This ensures Profile is correctly highlighted
              break;
          }
        },
      ),
    );
  }
}

// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool isPassword;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    this.initialValue,
    this.isPassword = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: isPassword
              ? const Icon(Icons.visibility_off, color: Colors.grey)
              : null,
        ),
      ),
    );
  }
}
