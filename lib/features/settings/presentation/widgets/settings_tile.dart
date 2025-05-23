import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.navigateTo,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final Widget title;
  final Widget? subTitle;
  final Widget? navigateTo;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(final BuildContext context) => ListTile(
    onTap:
        navigateTo != null
            ? () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => navigateTo!),
            )
            : onTap,
    leading: Icon(icon),
    title: title,
    subtitle: subTitle,
    trailing: navigateTo != null ? const Icon(Symbols.chevron_right) : trailing,
  );
}
