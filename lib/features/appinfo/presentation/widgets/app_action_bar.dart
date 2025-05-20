import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/constants/theme_constants.dart';
import '../../../../core/helpers/app_utils.dart';
import '../../application/app_info_provider.dart';
import './app_action_item.dart';

class AppActionBar extends ConsumerWidget {
  const AppActionBar({super.key, required this.app});

  final Application app;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final isAvailableOnPlayStore = ref.watch(
      isAppOnPlayStoreProvider(app.packageName),
    );

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
            isAvailableOnPlayStore.when(
              data: (final data) => _buildPlayStoreActionItem(app.packageName),
              loading: () => _buildPlayStoreActionItem(null),
              error: (_, _) => _buildPlayStoreActionItem(null),
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
}

Widget _buildPlayStoreActionItem(final String? packageName) {
  final isActive = packageName?.isNotEmpty ?? false;

  return AppActionItem(
    onTap: () => isActive ? AppUtils.openPlayStore(packageName!) : null,
    icon: Symbols.shop,
    label: 'Play Store',
    isActive: isActive,
  );
}
