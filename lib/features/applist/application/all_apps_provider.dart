import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/application/settings_provider.dart';
import './icon_provider.dart';

final allAppsProvider = FutureProvider<List<Application>>((final ref) async {
  final showNonLaunchable = ref.watch(
    settingsProvider.select((final s) => !s.showNonLaunchable),
  );

  final apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: false,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: showNonLaunchable,
  );

  apps.sort(
    (final a, final b) =>
        a.appName.toUpperCase().compareTo(b.appName.toUpperCase()),
  );

  ref.read(iconCacheProvider.notifier).cacheIcons(showNonLaunchable);

  return apps;
});
