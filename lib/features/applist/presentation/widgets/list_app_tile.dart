import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_tile.dart';
import '../../../../common/extract_share_toggle_button.dart';
import '../../../../helpers/app_operations_helper.dart';

class ListAppTile extends StatelessWidget {
  const ListAppTile({super.key, required this.app, required this.index});

  final Application app;
  final int index;

  @override
  Widget build(BuildContext context) => AppTile(
    onTap: () => AppOperationsHelper.navigateToAppInfo(context, app),
    title: app.appName,
    subTitle: app.packageName,
    packageName: app.packageName,
    index: index,
    trailing: ExtractShareToggleButton(app: app),
  );
}
