import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/app_card.dart';
import '../../../appinfo/application/app_info_provider.dart';
import '../../../appinfo/presentation/pages/app_info_page.dart';

class GridAppCard extends StatelessWidget {
  const GridAppCard({super.key, required this.app, required this.index});

  final Application app;
  final int index;

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
    return AppCard(
      app: app,
      onTap: () => _navigateToAppInfo(context),
      icon: (app as ApplicationWithIcon).icon,
      title: app.appName,
      subTitle: app.packageName,
      index: index,
    );
  }
}
