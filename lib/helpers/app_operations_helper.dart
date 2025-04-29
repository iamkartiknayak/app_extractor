import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppOperationsHelper {
  static Future<String?> extractApk(Application app) async {
    try {
      final extractionDir = await _getPrivateExtractionDirectory();
      if (extractionDir == null) {
        return null;
      }

      final sourceApkPath = app.apkFilePath;
      if (sourceApkPath.isEmpty) {
        return null;
      }

      final sanitizedAppName = app.appName.replaceAll(RegExp(r'[^\w\s]+'), '_');
      final destinationPath =
          '${extractionDir.path}/$sanitizedAppName-${app.versionName}.apk';

      final sourceFile = File(sourceApkPath);

      if (!await sourceFile.exists()) return null;

      await sourceFile.copy(destinationPath);
      return destinationPath;
    } catch (e) {
      debugPrint('Error extracting APK: $e');
      return null;
    }
  }

  static Future<Directory?> _getPrivateExtractionDirectory() async {
    try {
      final baseDir = await getExternalStorageDirectory();
      if (baseDir == null) return null;

      final extractorDir = Directory('${baseDir.path}/ApxExtractor');
      if (!await extractorDir.exists()) {
        await extractorDir.create(recursive: true);
      }
      return extractorDir;
    } catch (e) {
      debugPrint('Error creating private directory: $e');
      return null;
    }
  }
}
