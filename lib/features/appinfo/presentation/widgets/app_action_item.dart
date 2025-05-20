import 'package:flutter/material.dart';

class AppActionItem extends StatelessWidget {
  const AppActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(final BuildContext context) {
    final inActiveColor = Colors.grey.shade700;

    return Expanded(
      child: Material(
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        elevation: 3.0,
        child: InkWell(
          onTap: isActive ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: !isActive ? inActiveColor : null),
                const SizedBox(height: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    color: !isActive ? inActiveColor : null,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
