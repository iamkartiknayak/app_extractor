import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/app_utils.dart';
import '../../../core/helpers/box_helper.dart';
import '../data/models/extracted_app_model.dart';

final extractedAppsProvider =
    NotifierProvider<ExtractedAppsNotifier, ExtractedAppsState>(
      ExtractedAppsNotifier.new,
    );

class ExtractedAppsState {
  const ExtractedAppsState({
    this.extractedApps = const {},
    this.extractingApps = const {},
  });

  final Map<String, ExtractedAppModel> extractedApps;
  final Set<String> extractingApps;

  ExtractedAppsState copyWith({
    final Map<String, ExtractedAppModel>? extractedApps,
    final Set<String>? extractingApps,
  }) => ExtractedAppsState(
    extractedApps: extractedApps ?? this.extractedApps,
    extractingApps: extractingApps ?? this.extractingApps,
  );

  bool isExtracted(final String packageName) =>
      extractedApps.containsKey(packageName);
  bool isExtracting(final String packageName) =>
      extractingApps.contains(packageName);
}

class ExtractedAppsNotifier extends Notifier<ExtractedAppsState> {
  @override
  ExtractedAppsState build() {
    final extractedAppList = BoxHelper.instance.getExtractedAppsList();
    final extractedMap = {
      for (final app in extractedAppList) app.packageName: app,
    };
    return ExtractedAppsState(extractedApps: extractedMap);
  }

  Future<void> extractApk({
    required final Application app,
    final bool showSnackBar = true,
  }) async {
    if (state.isExtracted(app.packageName) ||
        state.isExtracting(app.packageName)) {
      return;
    }

    state = state.copyWith(
      extractingApps: {...state.extractingApps, app.packageName},
    );

    try {
      final defaultApkName = 'name_version.apk';
      final apkFileName = AppUtils.generateApkFileName(app, defaultApkName);

      final results = await Future.wait([
        AppUtils.getAppSize(app.apkFilePath),
        AppUtils.extractApk(app.apkFilePath, apkFileName),
      ]);

      final appSize = results[0]!;
      final extractedPath = results[1];
      if (extractedPath == null) {
        return;
      }

      final appWithIcon = await DeviceApps.getApp(app.packageName, true);
      final appIcon = (appWithIcon as ApplicationWithIcon).icon;

      final extractedApp = ExtractedAppModel(
        appIcon: appIcon,
        appName: app.appName,
        packageName: app.packageName,
        appSize: appSize,
        appPath: extractedPath,
      );

      final newExtractedApps = {
        ...state.extractedApps,
        app.packageName: extractedApp,
      };

      state = state.copyWith(extractedApps: newExtractedApps);
      await BoxHelper.instance.saveExtractedApps(
        newExtractedApps.values.toList(),
      );
    } finally {
      state = state.copyWith(
        extractingApps: {...state.extractingApps}..remove(app.packageName),
      );
    }
  }

  String? getExtractedApkPath(final String packageName) =>
      state.extractedApps[packageName]?.appPath;
}
