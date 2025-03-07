import 'package:clean_ease/app/di/di.dart';
import 'package:clean_ease/features/profile/domain/use_case/get_profile_use_case.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_bloc.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_event.dart';
import 'package:clean_ease/features/profile/presentation/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
        ),
        backgroundColor: Colors.teal,
      ),
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
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Profile Picture with Edit Icon
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: state.profile.image.isNotEmpty
                                ? NetworkImage(
                                    _formatImageUrl(state.profile.image))
                                : const AssetImage('assets/images/goats.jpg')
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
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Editable Form Fields
                      CustomTextField(
                        label: "Full Name",
                        initialValue: state.profile.fullname,
                      ),
                      CustomTextField(
                        label: "Phone Number",
                        initialValue: state.profile.phone,
                      ),
                      CustomTextField(
                        label: "Email",
                        initialValue: state.profile.email,
                      ),
                      CustomTextField(
                        label: "Address",
                        initialValue: state.profile.address,
                      ),
                      const SizedBox(height: 20),

                      // Save & Cancel Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implement Save logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context); // Back to Profile
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

// ✅ Custom Text Field Widget for Reusability
class CustomTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.label,
    this.initialValue,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
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
