import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/custom_alert_dialog.dart';
import '../../application/settings_provider.dart';

class DefaultFileNameDialog extends ConsumerWidget {
  const DefaultFileNameDialog({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final notifier = ref.read(settingsProvider.notifier);
    final defaultApkName = ref.watch(
      settingsProvider.select((final s) => s.defaultApkName),
    );

    const options = [
      'name_version.apk',
      'source_version.apk',
      'source.apk',
      'name.apk',
    ];

    return CustomAlertDialog(
      title: 'APK default file name',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            options
                .map(
                  (final option) => RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    value: option,
                    groupValue: defaultApkName,
                    title: Text(option),
                    onChanged: (final value) {
                      Navigator.of(context).pop();
                      notifier.setApkName(value);
                    },
                  ),
                )
                .toList(),
      ),
    );
  }
}
