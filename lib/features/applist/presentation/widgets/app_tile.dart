import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import './fallback_icon.dart';
import '../../../appinfo/application/app_info_provider.dart';
import '../../../appinfo/presentation/pages/app_info_page.dart';

class AppTile extends StatelessWidget {
  const AppTile({super.key, required this.app});

  final Application app;

  Widget getAppIcon() {
    return app is ApplicationWithIcon
        ? Image.memory((app as ApplicationWithIcon).icon, width: 40, height: 40)
        : FallbackIcon();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AppInfoPage(app: app)))
            .then((_) {
              if (!context.mounted) return;
              context.read<AppInfoProvider>().setSelectedAppId(null);
            });

        context.read<AppInfoProvider>().setSelectedAppId(app.packageName);
      },
      leading: getAppIcon(),
      title: Text(app.appName),
      subtitle: Text(app.packageName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed:
                () => context.read<AppInfoProvider>().extractApk(context, app),
            icon: Icon(Symbols.unarchive),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
