import 'package:device_apps/device_apps.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../core/helpers/app_utils.dart';

final openedAppIdProvider = StateProvider<String?>((final ref) => null);

final isAppOnPlayStoreProvider = FutureProvider.family<bool, String>((
  final ref,
  final packageName,
) async {
  try {
    final url = 'https://play.google.com/store/apps/details?id=$packageName';
    final response = await http.head(Uri.parse(url));
    return response.statusCode == 200;
  } catch (_) {
    return false;
  }
});

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
