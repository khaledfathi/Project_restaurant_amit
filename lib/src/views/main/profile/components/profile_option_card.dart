import 'package:flutter/material.dart';

class ProfileOptionCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final void Function()? onTap;
  const ProfileOptionCard({super.key, this.title, this.subtitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(title ?? 'title'),
        subtitle: Text(
          subtitle ?? 'subtitle',
          style: const TextStyle(color: Color.fromRGBO(155, 155, 155, 1)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
