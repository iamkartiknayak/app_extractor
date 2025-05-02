import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import '../../../../common/app_tile.dart';
import '../../../appinfo/application/app_info_provider.dart';
import '../../../appinfo/presentation/pages/app_info_page.dart';

class ListAppTile extends StatelessWidget {
  const ListAppTile({super.key, required this.app, required this.index});

  final Application app;
  final int index;

  String? _getExtractedPath(AppInfoProvider provider) {
    return provider.extractedAppsList
        .firstWhere((exApp) => exApp.packageName == app.packageName)
        .appPath;
  }

  void _navigateToAppInfo(BuildContext context) {
    context.read<AppInfoProvider>().setSelectedAppId(app.packageName);
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => AppInfoPage(app: app))).then((_) {
      if (!context.mounted) return;
      context.read<AppInfoProvider>().setSelectedAppId(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appIcon =
        app is ApplicationWithIcon ? (app as ApplicationWithIcon).icon : null;
    final appName = app.appName;
    final packageName = app.packageName;

    return AppTile(
      onTap: () => _navigateToAppInfo(context),
      icon: appIcon,
      title: appName,
      subTitle: packageName,
      index: index,
      trailing: Selector<AppInfoProvider, bool>(
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
              final appInfoProvider = context.read<AppInfoProvider>();
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
    );
  }
}
