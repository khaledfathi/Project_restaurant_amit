import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget implements PreferredSize {
  const LoginAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
