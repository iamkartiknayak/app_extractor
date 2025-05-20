import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/constants/theme_constants.dart';
import './app_action_item.dart';

class AppActionBar extends ConsumerWidget {
  const AppActionBar({super.key, required this.app});

  final Application app;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) =>
      IntrinsicHeight(
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
                isActive: false,
              ),
              const VerticalDivider(width: 1.0),
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
