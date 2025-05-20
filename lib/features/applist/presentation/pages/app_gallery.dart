import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../appinfo/application/favorite_apps_provider.dart';
import '../../application/installed_apps_provider.dart';
import '../../application/system_apps_provider.dart';
import '../widgets/build_app_list.dart';

enum AppGalleryType { installed, system, favorites }

class AppGallery extends ConsumerWidget {
  const AppGallery(this.type, {super.key});

  final AppGalleryType type;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    late final Provider<List<Application>> appProvider;
    late String title;

    switch (type) {
      case AppGalleryType.installed:
        appProvider = installedAppsProvider;
        title = 'Installed Apps';
        break;
      case AppGalleryType.system:
        appProvider = systemAppsProvider;
        title = 'System Apps';
        break;

      case AppGalleryType.favorites:
        appProvider = favoriteAppsProvider;
        title = 'Favorite Apps';
        break;
    }

    final apps = ref.watch(appProvider);

    return Scaffold(
      appBar: AppBar(title: Text('$title (${apps.length})')),
      body: Builder(builder: (final context) => BuildAppList(apps: apps)),
    );
  }
}
