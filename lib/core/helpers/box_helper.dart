import 'package:hive_flutter/hive_flutter.dart';

class BoxHelper {
  BoxHelper._internal();
  static final BoxHelper _instance = BoxHelper._internal();
  late final Box<dynamic> _appBox;

  static BoxHelper get instance => _instance;

  Future<void> init() async {
    await Hive.initFlutter();
    _appBox = await Hive.openBox<dynamic>('appData');
  }

  Box<dynamic> get appBox => _appBox;

  Future<void> saveFavorites(final List<String> favoriteAppsIdList) async {
    await _appBox.put('favoriteApps', favoriteAppsIdList);
  }

  List<String> getFavoriteAppsIdList() =>
      (_appBox.get('favoriteApps') as List?)?.whereType<String>().toList() ??
      [];
}
