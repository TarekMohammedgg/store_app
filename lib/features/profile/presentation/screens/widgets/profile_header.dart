import 'package:flutter/material.dart';
import 'package:store_app/features/login/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              user.image != null ? NetworkImage(user.image!) : null,
          child: user.image == null
              ? Icon(Icons.person, size: 50)
              : null,
        ),
        SizedBox(height: 12),
        Text(
          "${user.firstName ?? ''} ${user.lastName ?? ''}",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          "@${user.username ?? ''}",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
