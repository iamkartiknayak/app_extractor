import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:share_plus/share_plus.dart';

import '../features/appinfo/application/extracted_apps_provider.dart';

class ExtractShareButton extends ConsumerWidget {
  const ExtractShareButton({super.key, required this.app});

  final Application app;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final extractedState = ref.watch(extractedAppsProvider);
    final notifier = ref.read(extractedAppsProvider.notifier);

    final isExtracted = extractedState.isExtracted(app.packageName);
    final isExtracting = extractedState.isExtracting(app.packageName);

    return IconButton(
      onPressed:
          isExtracting
              ? null
              : () {
                if (!isExtracted) {
                  notifier.extractApk(app: app);
                } else {
                  final path = notifier.getExtractedApkPath(app.packageName);
                  if (path != null) {
                    SharePlus.instance.share(ShareParams(files: [XFile(path)]));
                  }
                }
              },
      icon:
          isExtracting
              ? const Icon(Symbols.unarchive)
              : Icon(
                isExtracted ? Symbols.share : Symbols.unarchive,
                color: Theme.of(context).colorScheme.primary,
              ),
    );
  }
}
