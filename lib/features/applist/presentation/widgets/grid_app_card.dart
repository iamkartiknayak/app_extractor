import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_card.dart';
import '../../../../helpers/app_operations_helper.dart';

class GridAppCard extends StatelessWidget {
  const GridAppCard({super.key, required this.app, required this.index});

  final Application app;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      app: app,
      onTap: () => AppOperationsHelper.navigateToAppInfo(context, app),
      title: app.appName,
      subTitle: app.packageName,
      index: index,
    );
  }
}
