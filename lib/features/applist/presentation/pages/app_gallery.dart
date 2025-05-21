import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../common/empty_data_widget.dart';
import '../../../appinfo/application/extracted_apps_provider.dart';
import '../../../appinfo/application/favorite_apps_provider.dart';
import '../../../settings/application/settings_provider.dart';
import '../../application/installed_apps_provider.dart';
import '../../application/long_press_provider.dart';
import '../../application/search_provider.dart';
import '../../application/system_apps_provider.dart';
import '../widgets/build_app_grid.dart';
import '../widgets/build_app_list.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/selection_app_bar.dart';

enum AppGalleryType { installed, system, favorites }

class AppGallery extends ConsumerWidget {
  const AppGallery(this.type, {super.key});

  final AppGalleryType type;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final exAppNotifier = ref.read(extractedAppsProvider.notifier);
    final longPress = ref.watch(longPressProvider);
    final gridView = ref.watch(
      settingsProvider.select((final s) => s.gridView),
    );

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
              ? SelectionAppBar(
                onPressed: () => exAppNotifier.batchExtractApks(ref, apps),
                icon: Symbols.unarchive,
              )
              : DefaultAppBar(title: title, apps: apps),
      body: Builder(
        builder: (_) {
          final noResults = ref.watch(
            searchProvider.select((final s) => s.noResults),
          );

          if (noResults) {
            return const EmptyDataWidget(
              icon: Symbols.search_off,
              title: 'No results found',
              subTitle: 'Try adjusting your search keywords',
            );
          }

          final searchList = ref.watch(
            searchProvider.select((final s) => s.filteredApps),
          );
          final appList = searchList.isNotEmpty ? searchList : apps;

          return gridView
              ? BuildAppGrid(apps: appList)
              : BuildAppList(apps: appList);
        },
      ),
    );
  }
}
