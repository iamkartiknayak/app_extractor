import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../features/appinfo/application/app_info_provider.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.app,
    required this.index,
    this.onTap,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  final Application app;

  final VoidCallback? onTap;
  final dynamic icon;
  final String title;
  final String subTitle;
  final int index;

  String? _getExtractedPath(AppInfoProvider provider) {
    return provider.extractedAppsList
        .firstWhere((exApp) => exApp.packageName == app.packageName)
        .appPath;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: kBorderRadius),
      onTap: onTap,
      child: Card(
        elevation: 1,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8.0),
              Image.memory(icon, height: 56.0, width: 56.0),
              SizedBox(height: 20.0),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => DeviceApps.openApp(app.packageName),
                    icon: Icon(
                      Symbols.launch,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed:
                        () => DeviceApps.openAppSettings(app.packageName),
                    icon: Icon(
                      Symbols.info,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  Selector<AppInfoProvider, bool>(
                    selector:
                        (_, provider) => provider.extractedAppsList.any(
                          (exApp) => exApp.packageName == app.packageName,
                        ),
                    builder: (context, isExtracted, _) {
                      return IconButton(
                        icon: Icon(
                          isExtracted ? Symbols.share : Symbols.unarchive,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          final appInfoProvider =
                              context.read<AppInfoProvider>();
                          if (isExtracted) {
                            final path = _getExtractedPath(appInfoProvider);
                            if (path != null) {
                              appInfoProvider.shareExtractedApp(path);
                            }
                          } else {
                            appInfoProvider.extractApk(context, app);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
