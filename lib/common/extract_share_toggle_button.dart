import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../features/appinfo/application/app_info_provider.dart';

class ExtractShareToggleButton extends StatelessWidget {
  const ExtractShareToggleButton({super.key, required this.app});

  final Application app;

  String? _getExtractedPath(AppInfoProvider provider) =>
      provider.extractedAppsList
          .firstWhere((exApp) => exApp.packageName == app.packageName)
          .appPath;

  @override
  Widget build(BuildContext context) => Selector<AppInfoProvider, bool>(
    selector:
        (_, provider) => provider.extractedAppsList.any(
          (exApp) => exApp.packageName == app.packageName,
        ),
    builder:
        (context, isExtracted, _) => IconButton(
          icon: Icon(
            isExtracted ? Symbols.share : Symbols.unarchive,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            final appInfoProvider = context.read<AppInfoProvider>();
            if (isExtracted) {
              final path = _getExtractedPath(appInfoProvider);
              if (path != null) {
                appInfoProvider.shareExtractedApp(path);
              }
            } else {
              appInfoProvider.extractApk(context: context, app: app);
            }
          },
        ),
  );
}
