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
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return Column(
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(state.profile.image)),
                Text(state.profile.name),
                Text(state.profile.address),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/edit_profile'),
                  child: const Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/change_password'),
                  child: const Text('Change Password'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(Logout());
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Logout'),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Failed to load profile'));
          }
        },
      ),
    );
  }
}
