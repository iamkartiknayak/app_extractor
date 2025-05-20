import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/application/settings_provider.dart';

final allAppsProvider = FutureProvider<List<Application>>((final ref) async {
  final settings = ref.watch(settingsProvider);

  final apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: false,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: !settings.showNonLaunchable,
  );

  apps.sort(
    (final a, final b) =>
        a.appName.toUpperCase().compareTo(b.appName.toUpperCase()),
  );
  return apps;
});
