import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';

class AppUtils {
  static Future<String> getAppSize(final String apkFilePath) async {
    final file = File(apkFilePath);
    if (await file.exists()) {
      final bytes = await file.length();
      return _formatBytes(bytes);
    }
    return '0 B';
  }

  static Future<Map<String, String>> detectTechStack(
    final String apkPath,
  ) async {
    final File apkFile = File(apkPath);

    if (!await apkFile.exists()) {
      return {'status': 'error', 'message': 'APK file does not exist'};
    }

    final Uint8List apkBytes = await apkFile.readAsBytes();
    final Archive archive = ZipDecoder().decodeBytes(apkBytes, verify: false);

    int flutterScore = 0;
    int reactScore = 0;
    int xamarinScore = 0;
    int composeScore = 0;
    int xmlAppScore = 0;

    bool isUnity = false;
    bool isCordova = false;
    bool isUnreal = false;
    bool isGodot = false;

    for (final file in archive.files) {
      final name = file.name;

      // Flutter
      if (name.contains('libflutter.so') ||
          name.contains('flutter_assets') ||
          name.contains('io/flutter') ||
          name.contains('libapp.so')) {
        flutterScore++;
      }

      // React Native
      if (name.contains('index.android.bundle') ||
          name.contains('react-native/') ||
          name.contains('libhermes.so') ||
          name.contains('libjscexecutor.so')) {
        reactScore++;
      }

      // Unity
      if (name.contains('libunity.so') ||
          name.contains('globalgamemanagers') ||
          name.contains('assets/bin/Data/')) {
        isUnity = true;
      }

      // Jetpack Compose
      if ((name.startsWith('META-INF/') && name.contains('androidx.compose')) ||
          name.contains('androidx/compose/')) {
        composeScore++;
      }

      // Traditional Android (XML layouts)
      if (name.startsWith('res/layout/') && name.endsWith('.xml') ||
          name.startsWith('res/') && name.endsWith('.xml') ||
          name.startsWith('res/drawable-') ||
          name.startsWith('res/xml') ||
          name.startsWith('res/color')) {
        xmlAppScore++;
      }

      // Xamarin/MAUI
      if (name.contains('assemblies/') ||
          name.contains('mono/') ||
          name.contains('sharedruntime/') ||
          name.endsWith('.dll') ||
          name.endsWith('.pdb') ||
          name.endsWith('.mdb') ||
          name.contains('libmonodroid.so') ||
          name.contains('libmonosgen-2.0.so') ||
          name.contains('Mono.Android.dll') ||
          name.contains('mscorlib.dll') ||
          name.contains('System.') ||
          name.contains('mono_config')) {
        xamarinScore++;
      }

      // Cordova/Ionic/Capacitor
      if (name.contains('assets/www/') ||
          name.contains('capacitor.config.json') ||
          name.contains('libcordova.so')) {
        isCordova = true;
      }

      // Unreal Engine
      if (name.contains('libUE4.so') || name.contains('UE4Game-Android')) {
        isUnreal = true;
      }

      // Godot
      if (name.contains('libgodot_android.so')) {
        isGodot = true;
      }
    }

    // Apply thresholds to reduce false positives
    final isFlutter = flutterScore >= 2;
    final isReactNative = reactScore >= 2;
    final hasComposeMarker = composeScore >= 2;
    final isXamarin = xamarinScore >= 2;
    final isTraditionalAndroid = xmlAppScore > 10 && !hasComposeMarker;
    final isComposeTradHybrid = composeScore > 0 && xmlAppScore > 3;

    // Priority order
    if (isFlutter) {
      return {'status': 'success', 'framework': 'Flutter'};
    } else if (isReactNative) {
      return {'status': 'success', 'framework': 'React Native'};
    } else if (isUnity) {
      return {'status': 'success', 'framework': 'Unity'};
    } else if (hasComposeMarker) {
      return {'status': 'success', 'framework': 'Jetpack Compose'};
    } else if (isComposeTradHybrid) {
      return {
        'status': 'success',
        'framework': 'Native Android (XML) + Jetpack Compose',
      };
    } else if (isTraditionalAndroid) {
      return {'status': 'success', 'framework': 'Native Android (XML)'};
    } else if (isXamarin) {
      return {'status': 'success', 'framework': 'Xamarin/MAUI'};
    } else if (isCordova) {
      return {'status': 'success', 'framework': 'Cordova/Capacitor'};
    } else if (isUnreal) {
      return {'status': 'success', 'framework': 'Unreal Engine'};
    } else if (isGodot) {
      return {'status': 'success', 'framework': 'Godot'};
    } else {
      return {'status': 'success', 'framework': 'Unknown'};
    }
  }

  // private methods
  static String _formatBytes(final int bytes, [final int decimals = 2]) {
    if (bytes <= 0) {
      return '0 B';
    }
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (log(bytes) / log(1024)).floor();
    final size = bytes / pow(1024, i);
    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
