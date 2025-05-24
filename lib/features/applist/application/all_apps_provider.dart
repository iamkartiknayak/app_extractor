import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/application/settings_provider.dart';
import './icon_provider.dart';

final allAppsProvider =
    AsyncNotifierProvider<AllAppsNotifier, List<Application>>(
      () => AllAppsNotifier(),
    );

class AllAppsNotifier extends AsyncNotifier<List<Application>> {
  @override
  Future<List<Application>> build() async => await _loadApps();

  Future<List<Application>> _loadApps() async {
    final showNonLaunchable = ref.watch(
      settingsProvider.select((final s) => !s.showNonLaunchable),
    );

    final apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: false,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: showNonLaunchable,
    );

    ref
        .read(iconCacheProvider.notifier)
        .cacheIcons(showNonLaunchable, apps.length);

    return _sortApps(apps);
  }

  void removeApp(final String packageName) {
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    state = AsyncData(
      current.where((final app) => app.packageName != packageName).toList(),
    );
  }

  Future<void> addApp(final String packageName) async {
    final current = state;

    if (current is AsyncData<List<Application>>) {
      final app = await DeviceApps.getApp(packageName, true);
      final updatedList = [...current.value, app!];
      state = AsyncData(_sortApps(updatedList));

      await ref
          .read(iconCacheProvider.notifier)
          .addIconToCache(packageName, (app as ApplicationWithIcon).icon);
    }
  }
}

List<Application> _sortApps(final List<Application> apps) {
  apps.sort(
    (final a, final b) =>
        a.appName.toUpperCase().compareTo(b.appName.toUpperCase()),
  );
  return apps;
}
