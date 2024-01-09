import 'package:flutter/material.dart';

class SignUpScreenAppBar extends StatelessWidget implements PreferredSize {
  const SignUpScreenAppBar({super.key});
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
