import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/settings_provider.dart';

class DefaultFileNameDialog extends StatelessWidget {
  const DefaultFileNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.read<SettingsProvider>();
    final defaultApkName = context.select<SettingsProvider, String>(
      (p) => p.defaultApkName,
    );
    return CustomAlertDialog(
      title: 'APK default file name',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              Navigator.of(context).pop();
              settingsProvider.setApkName(value);
            },
            value: 'name_version.apk',
            groupValue: defaultApkName,
            title: const Text('name_version.apk'),
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              Navigator.of(context).pop();
              settingsProvider.setApkName(value);
            },
            value: 'source_version.apk',
            groupValue: defaultApkName,
            title: const Text('source_version.apk'),
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              Navigator.of(context).pop();
              settingsProvider.setApkName(value);
            },
            value: 'source.apk',
            groupValue: defaultApkName,
            title: const Text('source.apk'),
          ),
          RadioListTile(
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              Navigator.of(context).pop();
              settingsProvider.setApkName(value);
            },
            value: 'name.apk',
            groupValue: defaultApkName,
            title: const Text('name.apk'),
          ),
        ],
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.actionButton,
  });

  final String title;
  final Widget content;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) => AlertDialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    title: Text(title),
    contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 12.0, 4.0),
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: content,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Cancel'),
      ),
      if (actionButton != null) actionButton!,
    ],
  );
}
