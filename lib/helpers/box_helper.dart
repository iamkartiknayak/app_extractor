import 'package:hive_flutter/hive_flutter.dart';

import '../features/appinfo/data/models/extracted_app_model.dart';

class BoxHelper {
  static final BoxHelper _instance = BoxHelper._internal();
  late final Box<dynamic> _appBox;

  BoxHelper._internal();

  static BoxHelper get instance => _instance;

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ExtractedAppModelAdapter());
    }
    _appBox = await Hive.openBox<dynamic>('appData');
  }

  Box<dynamic> get appBox => _appBox;

  Future<void> saveFavorites(List<String> favoriteAppsIdList) async {
    await _appBox.put('favoriteApps', favoriteAppsIdList);
  }

  List<String> getFavoriteAppsIdList() =>
      (_appBox.get('favoriteApps') as List?)?.whereType<String>().toList() ??
      [];

  Future<void> saveExtractedApps(
    List<ExtractedAppModel> extractedAppsList,
  ) async {
    await _appBox.put('extractedApps', extractedAppsList);
  }

  List<ExtractedAppModel> getExtractedAppsList() =>
      (_appBox.get('extractedApps') as List?)?.cast<ExtractedAppModel>() ?? [];
}
