import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/helpers/app_utils.dart';
import '../../../core/helpers/box_helper.dart';
import '../../applist/application/long_press_provider.dart';
import '../../settings/application/settings_provider.dart';
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
      final defaultApkName = ref.read(settingsProvider).defaultApkName;
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

  void batchExtractApks(final WidgetRef ref, final List<Application> apps) {
    final indexList = ref.read(selectedItemsProvider);
    resetSelection(ref);
    for (final index in indexList) {
      extractApk(app: apps[index]);
    }
  }

  Future<void> batchDeleteApks(
    final WidgetRef ref, {
    final bool showSnackbar = true,
  }) async {
    final selectedIndexes = ref.read(selectedItemsProvider);
    resetSelection(ref);

    final apps = state.extractedApps.values.toList();
    final updatedMap = {...state.extractedApps};

    await Future.wait(
      selectedIndexes.map((final index) async {
        if (index >= apps.length) {
          return;
        }

        final app = apps[index];
        final file = File(app.appPath);

        if (await file.exists()) {
          await file.delete();
        }

        updatedMap.remove(app.packageName);
      }),
    );

    state = state.copyWith(extractedApps: updatedMap);
    await BoxHelper.instance.saveExtractedApps(updatedMap.values.toList());
  }

  Future<void> deleteAllApks() async {
    final dir = await getExternalStorageDirectory();
    if (dir == null) {
      return;
    }

    final files = dir.listSync(recursive: true);
    for (final file in files) {
      if (file is File) {
        await file.delete();
      }
    }

    state = const ExtractedAppsState();
    await BoxHelper.instance.saveExtractedApps([]);
  }

  String? getExtractedApkPath(final String packageName) =>
      state.extractedApps[packageName]?.appPath;
}
