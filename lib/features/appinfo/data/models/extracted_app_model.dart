import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'extracted_app_model.g.dart';

@HiveType(typeId: 1)
class ExtractedAppModel {
  ExtractedAppModel({
    required this.appIcon,
    required this.appName,
    required this.packageName,
    required this.appSize,
    required this.appPath,
  });
  @HiveField(0)
  final Uint8List appIcon;

  @HiveField(1)
  final String appName;

  @HiveField(2)
  final String packageName;

  @HiveField(3)
  final String appSize;

  @HiveField(4)
  final String appPath;
}
