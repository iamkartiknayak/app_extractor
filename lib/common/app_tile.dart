import 'package:flutter/material.dart';

class AppTile extends StatelessWidget {
  const AppTile({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.trailingIcon,
    required this.trailingAction,
  });

  final VoidCallback? onTap;
  final dynamic icon;
  final String title;
  final String subTitle;
  final IconData trailingIcon;
  final VoidCallback trailingAction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.memory(icon, width: 40, height: 40),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: IconButton(
        onPressed: trailingAction,
        icon: Icon(trailingIcon),
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
