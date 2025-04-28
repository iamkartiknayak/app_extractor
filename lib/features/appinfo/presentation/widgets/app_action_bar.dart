import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import './app_action_item.dart';
import '../../../../constants.dart';

class AppActionBar extends StatelessWidget {
  const AppActionBar({super.key, required this.app});

  final Application app;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: kBorderRadius),
        child: Row(
          children: [
            AppActionItem(
              onTap: () => DeviceApps.openApp(app.packageName),
              icon: Symbols.launch,
              label: 'Open',
            ),
            const VerticalDivider(width: 1.0),
            AppActionItem(
              onTap: () {},
              icon: Symbols.shop,
              label: 'Play Store',
              // isActive: isAvailable,
            ),
            VerticalDivider(width: 1.0),
            AppActionItem(
              onTap: () => DeviceApps.openAppSettings(app.packageName),
              icon: Symbols.info,
              label: 'App Info',
            ),
            const VerticalDivider(width: 1.0),
            AppActionItem(
              onTap: () => DeviceApps.uninstallApp(app.packageName),
              icon: Symbols.delete,
              label: 'Uninstall',
            ),
          ],
        ),
      ),
    );
  }
}
