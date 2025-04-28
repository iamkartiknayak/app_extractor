import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import '../../../helpers/app_extract_helper.dart';
import '../../../helpers/snackbar_helper.dart';

class AppInfoProvider extends ChangeNotifier {
  void extractApk(BuildContext context, Application app) async {
    final extractedPath = await AppExtractHelper.extractApk(app);
    if (context.mounted) {
      SnackbarHelper.showDoneExtractionSnackbar(context, extractedPath);
    }
  }
}
