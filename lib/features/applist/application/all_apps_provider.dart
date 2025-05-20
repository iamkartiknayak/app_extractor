import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allAppsProvider = FutureProvider<List<Application>>((final ref) async {
  final apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: false,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: false,
  );

  apps.sort(
    (final a, final b) =>
        a.appName.toUpperCase().compareTo(b.appName.toUpperCase()),
  );
  return apps;
});
