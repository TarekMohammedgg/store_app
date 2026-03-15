import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/profile/data/repo/profile_repo.dart';
import 'package:store_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:store_app/features/profile/presentation/cubit/profile_states.dart';
import 'package:store_app/features/profile/presentation/screens/widgets/profile_header.dart';
import 'package:store_app/features/profile/presentation/screens/widgets/profile_info_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepo())..getCurrentUser(),
      child: Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is ProfileLogoutSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            if (state is ProfileSuccess) {
              final user = state.user;
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    ProfileHeader(user: user),
                    SizedBox(height: 24),
                    Card(
                      child: Column(
                        children: [
                          ProfileInfoTile(
                            icon: Icons.email,
                            title: "Email",
                            value: user.email ?? "N/A",
                          ),
                          Divider(height: 1),
                          ProfileInfoTile(
                            icon: Icons.person,
                            title: "Gender",
                            value: user.gender ?? "N/A",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                        icon: Icon(Icons.logout, color: Colors.white),
                        label: Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is ProfileLogoutLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProfileCubit>().logout();
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
