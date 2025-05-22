import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Map<String, Uint8List> build() => <String, Uint8List>{};

  void cacheIcons(final bool showNonLaunchable) {
    Future.microtask(() async {
      final appsWithIcons = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: showNonLaunchable,
      );

      final Map<String, Uint8List> updates = {};

      for (final app in appsWithIcons) {
        final appIcon = (app as ApplicationWithIcon).icon;
        if (state.containsKey(app.packageName) &&
            state[app.packageName] == appIcon) {
          continue;
        }
        updates[app.packageName] = appIcon;
      }

      if (updates.isNotEmpty) {
        state = {...state, ...updates};
      }
    });
  }
}
