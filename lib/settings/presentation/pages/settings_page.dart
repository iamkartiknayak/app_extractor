import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import './app_about_page.dart';
import '../widgets/side_header.dart';
import '../widgets/default_file_name_dialog.dart';
import '../../application/settings_provider.dart';
import '../../../features/appinfo/application/app_info_provider.dart';
import '../../../features/applist/presentation/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SideHeader(header: 'Settings'),
          SettingsTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    title: 'Delete All?',
                    content: Text('Permanently delete all extracted APKs?'),
                    actionButton: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context
                            .read<AppInfoProvider>()
                            .deleteAllExtractedApps();
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Symbols.delete_forever,
            title: Text('Delete extracted APKs'),
            subTitle: Text('Remove all extracted APKs from storage'),
          ),
          SettingsTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => DefaultFileNameDialog(),
              );
            },
            icon: Symbols.save_as,
            title: Text('Default filename for extracted APKs'),
            subTitle: Selector<SettingsProvider, String>(
              selector: (_, provider) => provider.defaultApkName,
              builder: (_, value, _) {
                return Text(value);
              },
            ),
          ),
          SideHeader(header: 'Customization'),
          SettingsTile(
            icon: Symbols.grid_view,
            title: Text('Grid layout'),
            trailing: Selector<SettingsProvider, bool>(
              selector: (_, provider) => provider.gridView,
              builder: (_, value, _) {
                return Switch(
                  value: value,
                  onChanged:
                      (value) =>
                          context.read<SettingsProvider>().toggleGridView(),
                );
              },
            ),
          ),

          SideHeader(header: 'About'),
          SettingsTile(
            icon: Symbols.info,
            title: Text('App Info'),
            navigateTo: AppAboutPage(),
          ),
        ],
      ),
    );
  }
}
