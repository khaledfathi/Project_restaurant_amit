import 'package:flutter/material.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';

class ProfileScreen extends StatelessWidget {
  //route
  static const String route = 'profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screen'),
            ElevatedButton(
                onPressed: () => Auth.logout(context),
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
