import 'package:app_install_events/app_install_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/appinfo/application/app_info_provider.dart';
import '../../features/applist/application/all_apps_provider.dart';

class AppEventHelper {
  AppEventHelper(this.ref, this.context) {
    _appIUEvents = AppIUEvents();
    _appIUEvents.appEvents.listen(_handleEvent);
  }

  final WidgetRef ref;
  final BuildContext context;
  late final AppIUEvents _appIUEvents;

  void _handleEvent(final IUEvent event) {
    if (!context.mounted) {
      return;
    }

    final allAppsNotifier = ref.read(allAppsProvider.notifier);

    if (event.type == IUEventType.uninstalled) {
      allAppsNotifier.removeApp(event.packageName);

      if (ref.read(openedAppIdProvider) == event.packageName) {
        Navigator.of(context).pop();
      }
    }

    allAppsNotifier.addApp(event.packageName);
  }

  void dispose() {
    _appIUEvents.dispose();
  }
}
