import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../common/custom_alert_dialog.dart';
import '../../../appinfo/application/extracted_apps_provider.dart';
import './settings_tile.dart';

class DeleteExtractedApksTile extends ConsumerWidget {
  const DeleteExtractedApksTile({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) => SettingsTile(
    onTap: () {
      showDialog<void>(
        context: context,
        builder:
            (final BuildContext context) => CustomAlertDialog(
              title: 'Delete All?',
              content: const Text('Permanently delete all extracted APKs?'),
              actionButton: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(extractedAppsProvider.notifier).deleteAllApks();
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
      );
    },
    icon: Symbols.delete_forever,
    title: const Text('Delete extracted APKs'),
    subTitle: const Text('Remove all extracted APKs from storage'),
  );
}
