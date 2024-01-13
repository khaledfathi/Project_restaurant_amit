import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Text(
        'My Profile',
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      ),
    );
  }
}
