import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../../../common/app_tile.dart';
import '../../../appinfo/application/app_info_provider.dart';
import '../../../appinfo/presentation/pages/app_info_page.dart';

class ListAppTile extends StatelessWidget {
  const ListAppTile({super.key, required this.app});

  final Application app;

  @override
  Widget build(BuildContext context) {
    return AppTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AppInfoPage(app: app)))
            .then((_) {
              if (!context.mounted) return;
              context.read<AppInfoProvider>().setSelectedAppId(null);
            });

        context.read<AppInfoProvider>().setSelectedAppId(app.packageName);
      },
      icon: (app as ApplicationWithIcon).icon,
      title: app.appName,
      subTitle: app.packageName,
      trailingIcon: Symbols.unarchive,
      trailingAction:
          () => context.read<AppInfoProvider>().extractApk(context, app),
    );
  }
}
