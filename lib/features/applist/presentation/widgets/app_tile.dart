import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import './fallback_icon.dart';
import '../../../../helpers/snackbar_helper.dart';
import '../../../../helpers/app_extract_helper.dart';
import '../../../appinfo/presentation/pages/app_info_page.dart';

class AppTile extends StatelessWidget {
  const AppTile({super.key, required this.app});

  final Application app;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap:
          () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AppInfoPage(app: app))),
      leading:
          app is ApplicationWithIcon
              ? Image.memory(
                (app as ApplicationWithIcon).icon,
                width: 40,
                height: 40,
              )
              : FallbackIcon(),
      title: Text(app.appName),
      subtitle: Text(app.packageName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () async {
              final extractedPath = await AppExtractHelper.extractApk(app);
              if (context.mounted) {
                SnackbarHelper.showDoneExtractionSnackbar(
                  context,
                  extractedPath,
                );
              }
            },
            icon: Icon(Symbols.unarchive),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
