import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../appinfo/application/favorite_apps_provider.dart';
import '../../application/installed_apps_provider.dart';
import '../../application/long_press_provider.dart';
import '../../application/system_apps_provider.dart';
import '../widgets/build_app_list.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/selection_app_bar.dart';

enum AppGalleryType { installed, system, favorites }

class AppGallery extends ConsumerWidget {
  const AppGallery(this.type, {super.key});

  final AppGalleryType type;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final longPress = ref.watch(longPressProvider);

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
      appBar:
          longPress
              ? SelectionAppBar(onPressed: () {}, icon: Symbols.unarchive)
              : DefaultAppBar(title: title, count: apps.length),
      body: Builder(builder: (final context) => BuildAppList(apps: apps)),
    );
  }
}
