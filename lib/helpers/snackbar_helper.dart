import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SnackbarHelper {
  static void showDoneExtractionSnackbar(
    BuildContext context,
    String? extractedPath,
    String appName,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            extractedPath != null
                ? Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: appName,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(text: ' has been extracted successfully'),
                    ],
                  ),
                )
                : Text('Failed to extract APK'),
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
