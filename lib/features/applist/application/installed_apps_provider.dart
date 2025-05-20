import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './all_apps_provider.dart';

final installedAppsProvider = Provider<List<Application>>((final ref) {
  final allApps = ref
      .watch(allAppsProvider)
      .maybeWhen(data: (final apps) => apps, orElse: () => <Application>[]);

  return allApps.where((final app) => !(app.systemApp)).toList();
});
