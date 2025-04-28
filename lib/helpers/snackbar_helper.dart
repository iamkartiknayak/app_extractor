import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SnackbarHelper {
  static void showDoneExtractionSnackbar(
    BuildContext context,
    String? extractedPath,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          extractedPath != null
              ? 'APK extracted to: $extractedPath'
              : 'Failed to extract APK',
        ),
        action: SnackBarAction(
          label: 'Share',
          onPressed: () {
            if (extractedPath != null) {
              final file = File(extractedPath);
              SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
            }
          },
        ),
      ),
    );
  }
}
