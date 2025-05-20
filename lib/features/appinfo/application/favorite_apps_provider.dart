import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/box_helper.dart';
import '../../applist/application/all_apps_provider.dart';

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  () => FavoritesNotifier(),
);

final favoriteAppsProvider = Provider<List<Application>>((final ref) {
  final allApps = ref
      .watch(allAppsProvider)
      .maybeWhen(data: (final apps) => apps, orElse: () => <Application>[]);

  final favorites = ref.watch(favoritesProvider);
  return allApps
      .where((final Application app) => favorites.contains(app.packageName))
      .toList();
});

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => BoxHelper.instance.getFavoriteAppsIdList().toSet();

  void toggleFavorite(final String packageName) {
    if (state.contains(packageName)) {
      state = {...state}..remove(packageName);
    } else {
      state = {...state}..add(packageName);
    }
    BoxHelper.instance.saveFavorites(state.toList());
  }

  bool isFavorite(final String packageName) => state.contains(packageName);
}
