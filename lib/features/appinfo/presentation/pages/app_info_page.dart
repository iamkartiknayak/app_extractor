import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../widgets/app_info_tile.dart';
import '../widgets/app_action_bar.dart';
import '../widgets/info_page_header.dart';
import '../../../../helpers/date_time_helper.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key, required this.app});

  final Application app;

  String getAppCategory(ApplicationCategory appCategory) =>
      appCategory.toString().split('.').last.capitalize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 8.0),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Symbols.unarchive)),
          IconButton(onPressed: () {}, icon: Icon(Symbols.share)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            InfoPageHeader(app: app),
            SizedBox(height: 8.0),
            AppActionBar(app: app),
            SizedBox(height: 24.0),
            AppInfoTile(
              value: app.appName,
              icon: Symbols.title,
              label: 'App name',
            ),
            Divider(),
            AppInfoTile(
              value: app.packageName,
              icon: Symbols.package_2,
              label: 'Package name',
            ),
            Divider(),
            AppInfoTile(
              value: getAppCategory(app.category),
              icon: Symbols.category,
              label: 'App category',
            ),
            Divider(),
            AppInfoTile(
              value: app.enabled.toString().capitalize(),
              icon: Symbols.toggle_off,
              label: 'Enabled',
            ),
            Divider(),
            AppInfoTile(
              value: DatetimeHelper.formatEpochTime(app.installTimeMillis),
              icon: Symbols.calendar_clock,
              label: 'Installed on',
            ),
            Divider(),
            AppInfoTile(
              value: app.systemApp.toString().capitalize(),
              icon: Symbols.phone_android,
              label: 'System App',
            ),
            Divider(),
            AppInfoTile(
              value: app.dataDir ?? 'Not available',
              icon: Symbols.folder,
              label: 'Data directory',
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return isEmpty ? this : this[0].toUpperCase() + substring(1);
  }
}
