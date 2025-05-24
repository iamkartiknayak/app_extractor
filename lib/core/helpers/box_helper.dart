import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

import '../../features/appinfo/data/models/extracted_app_model.dart';

class BoxHelper {
  BoxHelper._internal();
  static final BoxHelper _instance = BoxHelper._internal();
  late final Box<dynamic> _appBox;
  late final Box<dynamic> _settingsBox;

  static BoxHelper get instance => _instance;

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExtractedAppModelAdapter());
    }
    _appBox = await Hive.openBox<dynamic>('appData');
    _settingsBox = await Hive.openBox<dynamic>('settingsBox');
  }

  Box<dynamic> get appBox => _appBox;
  Box<dynamic> get settingsBox => _settingsBox;

  Future<void> saveFavorites(final List<String> favoriteAppsIdList) async {
    await _appBox.put('favoriteApps', favoriteAppsIdList);
  }

  List<String> getFavoriteAppsIdList() =>
      (_appBox.get('favoriteApps') as List?)?.whereType<String>().toList() ??
      [];

  Future<void> saveExtractedApps(
    final List<ExtractedAppModel> extractedAppsList,
  ) async {
    await _appBox.put('extractedApps', extractedAppsList);
  }

  List<ExtractedAppModel> getExtractedAppsList() =>
      (_appBox.get('extractedApps') as List?)?.cast<ExtractedAppModel>() ?? [];

  Future<void> saveIconCache(final Map<String, Uint8List> iconCache) async {
    await _appBox.put('iconCache', iconCache);
    await _appBox.compact();
  }

  Map<String, Uint8List> getIconCache() {
    final raw = _appBox.get('iconCache');
    if (raw is Map) {
      return raw.map(
        (final key, final value) =>
            MapEntry(key.toString(), value as Uint8List),
      );
    }
    return {};
  }
}
