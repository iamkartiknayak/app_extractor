import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/helpers/app_utils.dart';

final appAnalysisProvider =
    FutureProvider.family<AppAnalysisResult, Application>((
      final ref,
      final app,
    ) async {
      final path = app.apkFilePath;
      final techStack = await AppUtils.detectTechStack(path);
      final size = await AppUtils.getAppSize(path);
      return AppAnalysisResult(
        techStack: techStack['framework'] ?? 'Unknown',
        size: size,
      );
    });

class AppAnalysisResult {
  AppAnalysisResult({required this.techStack, required this.size});

  final String techStack;
  final String size;
}
