import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSnackbar({
    required BuildContext context,
    required String? extractedPath,
    required String appName,
    required String successMessage,
    required String errorMessage,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 1),
        content:
            extractedPath != null
                ? Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: appName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(text: successMessage),
                    ],
                  ),
                )
                : Text(errorMessage),
      ),
    );
  }
}
