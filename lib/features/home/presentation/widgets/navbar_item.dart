import 'package:flutter/material.dart';

class NavbarItem extends StatelessWidget {
  const NavbarItem({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(final BuildContext context) => NavigationDestination(
    label: label,
    icon: Icon(icon),
    selectedIcon: Icon(icon, fill: 1),
  );
}
