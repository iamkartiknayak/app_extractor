import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/box_helper.dart';

final iconCacheProvider =
    NotifierProvider<IconCacheNotifier, Map<String, Uint8List>>(
      IconCacheNotifier.new,
    );

final iconProvider = Provider.family<Uint8List?, String>((
  final ref,
  final packageName,
) {
  final cache = ref.watch(iconCacheProvider);
  return cache[packageName];
});

class IconCacheNotifier extends Notifier<Map<String, Uint8List>> {
  @override
  Map<String, Uint8List> build() => BoxHelper.instance.getIconCache();

  void cacheIcons(final bool showNonLaunchable, final int appListLength) {
    Future.microtask(() async {
      if (state.length >= appListLength) {
        return;
      }

      final appsWithIcons = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: showNonLaunchable,
      );

      final Map<String, Uint8List> updates = {};

      for (final app in appsWithIcons) {
        final icon = (app as ApplicationWithIcon).icon;
        final cachedIcon = state[app.packageName];
        if (cachedIcon != null && listEquals(cachedIcon, icon)) {
          continue;
        }
        updates[app.packageName] = icon;
      }

      if (updates.isNotEmpty) {
        state = {...state, ...updates};
        await BoxHelper.instance.saveIconCache(state);
      }
    });
  }
}
