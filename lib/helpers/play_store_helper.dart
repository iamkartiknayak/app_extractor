import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PlayStoreHelper {
  static Future<bool> isAppAvailable(String packageName) async {
    try {
      final url = 'https://play.google.com/store/apps/details?id=$packageName';
      final response = await http.head(Uri.parse(url));

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error checking Play Store availability: $e');
      return false;
    }
  }

  static Future<void> openPlayStore(String packageName) async {
    final url = Uri.parse('market://details?id=$packageName');
    final playStoreUrl = Uri.parse(
      'https://play.google.com/store/apps/details?id=$packageName',
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(playStoreUrl)) {
        await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch Play Store');
      }
    } catch (e) {
      debugPrint('Error launching Play Store: $e');
    }
  }
}
