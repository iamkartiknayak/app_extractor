import 'dart:typed_data';

class ExtractedAppModel {
  ExtractedAppModel({
    required this.appIcon,
    required this.appName,
    required this.packageName,
    required this.appSize,
    required this.appPath,
  });

  final Uint8List appIcon;
  final String appName;
  final String packageName;
  final String appSize;
  final String appPath;
}
